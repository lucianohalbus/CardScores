//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class UserRepository: ObservableObject {
    private let path: String = "User"
    private let db = Firestore.firestore()
    @Published var userModel: [UserModel] = []
    @Published var user: ProfileModel
    @Published var userProfile: ProfileModel
    @Published var userName: String = ""
    @Published var password = ""
    @Published var email = ""
    @Published var alertMessage: String = ""
    @Published var alertSuggestion: String = ""
    @Published var showAlert: Bool = false
    @Published var isUserCreated: Bool = false
    @Published var listOfFriends: [String] = []
    @Published var listOfTeamsRanking: [TeamModel] = []
    @Published var isUserAnonymous: Bool = false
    var handle: AuthStateDidChangeListenerHandle?
    @Published var friendsList: [FriendsModel] = []
    
    var createdTime: Date = Date()
    
    init() {
        
        user = ProfileModel(
            userId: "",
            userName: "",
            userEmail: "",
            friends: [FriendsModel(friendId: "", friendEmail: "", friendName: "")],
            createdTime: Date(),
            numberOfWins: 0,
            averageScores: 0,
            numberOfMatches: 0
        )
        
        userProfile = ProfileModel(
            userId: "",
            userName: "",
            userEmail: "",
            friends: [FriendsModel(friendId: "", friendEmail: "", friendName: "")],
            createdTime: Date(),
            numberOfWins: 0,
            averageScores: 0,
            numberOfMatches: 0
        )
        
        listen()
        
        getUser()
    }
       
    func listen() {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.createdTime = auth.currentUser?.metadata.creationDate ?? Date()
                
                if let email = auth.currentUser?.email {
                    self.isUserAnonymous = false
                }
                
            } else {
                print("USER NOT FOUND")
            }
        }
    }
    
    func getUser() {
        if let userId = Auth.auth().currentUser?.uid {
            db.collection(path)
                .whereField("userId", isEqualTo: userId)
                .addSnapshotListener{ (snapshot, error) in
                    if let snapshot = snapshot {
                        self.userModel = snapshot.documents.compactMap { document in
                            do {
                                let returnedUser = try document.data(as: UserModel.self)
                                
                                self.isUserCreated = true
                                
                                self.listOfFriends = returnedUser.friendsName

                                self.user = ProfileModel(
                                    userId: returnedUser.userId ?? "",
                                    userName: returnedUser.userName,
                                    userEmail: returnedUser.userEmail,
                                    friends: [
                                        FriendsModel(
                                            friendId: returnedUser.userId ?? "",
                                            friendEmail: returnedUser.userEmail,
                                            friendName: returnedUser.userName
                                        )
                                    ],
                                    createdTime: Date(),
                                    numberOfWins: Int(returnedUser.averageScores),
                                    averageScores: Int(returnedUser.averageScores),
                                    numberOfMatches: Int(returnedUser.numberOfWins)
                                )
                                
                                return returnedUser
                            }
                            catch {
                                print(error)
                            }
                            return nil
                        }
                        
                        if !self.user.userEmail.isEmpty {
                            self.isUserAnonymous = false
                        } else {
                            self.isUserAnonymous = true
                        }
                    }
                }
        }
    }
    
    func getUserList(userId: String) async -> ProfileModel {
        let userDoc = db.collection(Constants.userList).document(userId)
        
        do {
          let document = try await userDoc.getDocument()
          if document.exists {
              let returnedDoc = try document.data(as: ProfileModel.self)
              
              self.userProfile = ProfileModel(userId: returnedDoc.userId, userName: returnedDoc.userName, userEmail: returnedDoc.userEmail, friends: returnedDoc.friends, createdTime: returnedDoc.createdTime, numberOfWins: returnedDoc.numberOfWins, averageScores: returnedDoc.averageScores, numberOfMatches: returnedDoc.numberOfMatches)
              
              return userProfile
              
          } else {
            print("User does not exist")
          }
        } catch {
          print("Error getting document: \(error)")
        }
        
        return userProfile
    }
    
    func addToFriendList() {
            db.collection(path)
                .addSnapshotListener{ (snapshot, error) in
                    if let snapshot = snapshot {
                        self.userModel = snapshot.documents.compactMap { document in
                            do {
                                let returnedUser = try document.data(as: UserModel.self)
                                
                                let myUser = ProfileModel(
                                    userId: returnedUser.userId ?? "",
                                    userName: returnedUser.userName,
                                    userEmail: returnedUser.userEmail,
                                    friends: [
                                        FriendsModel(
                                            friendId: returnedUser.userId ?? "",
                                            friendEmail: returnedUser.userEmail,
                                            friendName: returnedUser.userName
                                        )
                                    ],
                                    createdTime: Date(),
                                    numberOfWins: 0,
                                    averageScores: 0,
                                    numberOfMatches: 0
                                )
                                
                                if let userId = returnedUser.userId {
                                    try? self.db.collection(Constants.userList).document(userId).setData(from: myUser)
                                }
                            }
                            catch {
                                print(error)
                            }
                            return nil
                        }
                    }
                }
        
        
    }
    
    func getAllUsers() {
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
    
    func register(email: String, password: String, userName: String) {
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
                        userName: userName,
                        userEmail: email,
                        userId: result?.user.uid,
                        numberOfWins: 0,
                        averageScores: 0,
                        numberOfMatches: 0,
                        friendsMail: [email],
                        friendsName: [userName]
                    )
                )
            }
        }
    }
    
    func linkAnonymousUser(email: String, password: String, userName: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
           Auth.auth().currentUser?.link(with: credential) { result, error in
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
                        userName: userName,
                        userEmail: email,
                        userId: result?.user.uid,
                        numberOfWins: 0,
                        averageScores: 0,
                        numberOfMatches: 0,
                        friendsMail: [email],
                        friendsName: [userName]
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
    
    
    func addFriend(friend: String) {
        if let userId = Auth.auth().currentUser?.uid {
            let friendRef = db.collection("User").document(userId)
            friendRef.updateData([
                "friendsName": FieldValue.arrayUnion([friend])
            ])
        }
    }
    
    func addFriendEmail(email: String) {
        if let userId = Auth.auth().currentUser?.uid {
            let friendRef = db.collection("User").document(userId)
            friendRef.updateData([
                "friendsMail": FieldValue.arrayUnion([email])
            ])
        }
    }
    
    func removeFriend(friend: String) {
        if let userId = Auth.auth().currentUser?.uid {
            let friendRef = db.collection("User").document(userId)
            friendRef.updateData([
                "friendsName": FieldValue.arrayRemove([friend])
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
