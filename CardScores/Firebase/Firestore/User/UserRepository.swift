//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class UserRepository: ObservableObject {
    private let path: String = "User"
    private let db = Firestore.firestore()
    @Published var userModel: [UserModel] = []
    @Published var userName: String = ""
    @Published var password = ""
    @Published var email = ""
    @Published var alertMessage: String = ""
    @Published var alertSuggestion: String = ""
    @Published var showAlert: Bool = false
    @Published var isUserCreated: Bool = false
    var handle: AuthStateDidChangeListenerHandle?

    init() {
       getUser()
    }
    
    func getUser() {
        if let myEmail = Auth.auth().currentUser?.email {
        db.collection(path)
            .order(by: "numberOfWins", descending: true)
            .whereField("friendsMail", arrayContains: myEmail)
            .addSnapshotListener{ (snapshot, error) in
                if let snapshot = snapshot {
                    self.userModel = snapshot.documents.compactMap { document in
                        do {
                            let x = try document.data(as: UserModel.self)
                            self.isUserCreated = true
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let returnedError = error {
                let err = returnedError as NSError
                switch err.code {
                case AuthErrorCode.invalidEmail.rawValue:
                    self.alertMessage = "Invalid Email"
                    self.alertSuggestion = "Enter a valid email address"
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.alertMessage = "Email is already in use"
                    self.alertSuggestion = "If this is your email, reset the password"
                case AuthErrorCode.weakPassword.rawValue:
                    self.alertMessage = "Weak Password"
                    self.alertSuggestion = "Password must be 6 characters long or more"
                default:
                    self.alertMessage = "Error"
                    self.alertSuggestion = "\(err.localizedDescription)"
                }
                self.showAlert = true
            } else {
                guard let email = result?.user.email else {
                    print("User not Created.")
                    return
                }

                self.addUser(
                    UserModel(
                        id: result?.user.uid,
                        userName: self.userName,
                        userEmail: email,
                        userId: result?.user.uid,
                        numberOfWins: 0,
                        averageScores: 0,
                        numberOfMatches: 0,
                        friendsMail: [email],
                        friendsName: [],
                        createdTime: Date()
                    )
                )
            }
        }
    }
    
    func addUser(_ userModel: UserModel) {
        if let userId = Auth.auth().currentUser?.uid {
            do {
                _ = try db.collection(path).document(userId).setData(from: userModel)
                self.isUserCreated.toggle()
            } catch {
                fatalError("Adding a study card failed")
            }
        }
    }
    
    
    func removeUser(_ userModel: UserModel) {
        if let scoreModelID = userModel.id {
            db.collection(path).document(scoreModelID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    
    func updateUser(_ userModel: UserModel) {
        guard let documentID = userModel.id else { return }
        do {
            try db.collection(path).document(documentID).setData(from:
                                                                    userModel)
        } catch {
            fatalError("Adding a study card failed")
        }
    }
    
    
    func addUserFriend(_ myFriend:String) {
        if let userId = Auth.auth().currentUser?.uid {
            let friendRef = db.collection("User").document(userId)
            friendRef.updateData([
                "friendsMail": FieldValue.arrayUnion([myFriend])
            ])
        }
    }
    
    
    func updateRankingFriends(_ emailFriend:String, scoreFriend:Double) {
        db.collection("User")
            .whereField("userEmail", isEqualTo: emailFriend)
        
    }
    
    
    func updateWin(_ d: Double, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["numberOfWins": FieldValue.increment(1.0)])
    }
    
    
    func updateMatches(_ d: Double, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["numberOfMatches": FieldValue.increment(1.0)])
    }
    
    func updateScores(_ score:Int64, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["averageScores": FieldValue.increment(score)])
    }
     
    
}
