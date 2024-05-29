//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class UserRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let UserListCollection = Firestore.firestore().collection("UserList")
    @Published var userModel: [UserModel] = []
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
    var handle: AuthStateDidChangeListenerHandle?

    var createdTime: Date = Date()
    
    init() {

        userProfile = ProfileModel(
            userId: "",
            userName: "",
            userEmail: "",
            friends: [FriendsModel(friendId: "", friendEmail: "", friendName: "")],
            createdTime: Date(),
            numberOfWins: 0,
            averageScores: 0,
            numberOfMatches: 0,
            isUserAnonymous: false
        )
        
        listen()
        
      //  getUser()
    }
    
    func getUserList(userId: String) async -> ProfileModel {
        let userDoc = db.collection(Constants.userList).document(userId)
        
        do {
          let document = try await userDoc.getDocument()
          if document.exists {
              let returnedDoc = try document.data(as: ProfileModel.self)

              self.userProfile = ProfileModel(
                userId: returnedDoc.userId,
                userName: returnedDoc.userName,
                userEmail: returnedDoc.userEmail,
                friends: returnedDoc.friends,
                createdTime: returnedDoc.createdTime,
                numberOfWins: returnedDoc.numberOfWins,
                averageScores: returnedDoc.averageScores,
                numberOfMatches: returnedDoc.numberOfMatches,
                isUserAnonymous: Auth.auth().currentUser?.isAnonymous ?? false
              )
    
              return userProfile
              
          } else {
              self.userProfile = ProfileModel(
                userId: Auth.auth().currentUser?.uid ?? "",
                userName: "Usuário Anônimo",
                userEmail: "Usuário Anônimo",
                friends: [],
                createdTime: Date(),
                numberOfWins: 0,
                averageScores: 0,
                numberOfMatches: 0,
                isUserAnonymous: Auth.auth().currentUser?.isAnonymous ?? true
              )
              
              return userProfile
          }
        } catch {
          print("Error getting document: \(error)")
        }
        
        return userProfile
    }
    
    
    func userListDocument(userId: String) -> DocumentReference {
        UserListCollection.document(userId)
    }
       
    func listen() {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.createdTime = auth.currentUser?.metadata.creationDate ?? Date()
            } else {
                print("USER NOT FOUND")
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
                
                if let userId = result?.user.uid {
                    self.addUser(profileModel:
                        ProfileModel(
                            userId: userId,
                            userName: userName,
                            userEmail: email,
                            friends: [
                                FriendsModel(
                                    friendId: userId,
                                    friendEmail: email,
                                    friendName: userName
                                )
                            ],
                            createdTime: Date(),
                            numberOfWins: 0,
                            averageScores: 0,
                            numberOfMatches: 0,
                            isUserAnonymous: Auth.auth().currentUser?.isAnonymous ?? false
                        )
                    )
                }
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
                
                if let userId = result?.user.uid {
                    self.addUser(profileModel:
                        ProfileModel(
                            userId: userId,
                            userName: userName,
                            userEmail: email,
                            friends: [
                                FriendsModel(
                                    friendId: userId,
                                    friendEmail: email,
                                    friendName: userName
                                )
                            ],
                            createdTime: Date(),
                            numberOfWins: 0,
                            averageScores: 0,
                            numberOfMatches: 0,
                            isUserAnonymous: Auth.auth().currentUser?.isAnonymous ?? false
                        )
                    )
                }
            }
        }
    }
    
    func addUser(profileModel: ProfileModel) {
        if let userId = Auth.auth().currentUser?.uid {
            do {
                _ = try db.collection(Constants.userList).document(userId).setData(from: profileModel)
                self.isUserCreated.toggle()
            } catch {
                fatalError("Adding a study card failed")
            }
        }
    }
    
    func removeFriend(friend: FriendsModel, currentUser: ProfileModel) -> Bool {
        var friendArray: [FriendsModel] = currentUser.friends
        friendArray.removeAll { $0 == friend }
        let newUser: ProfileModel = ProfileModel(
            userId: currentUser.userId,
            userName: currentUser.userName,
            userEmail: currentUser.userEmail,
            friends: friendArray,
            createdTime: currentUser.createdTime,
            numberOfWins: currentUser.numberOfWins,
            averageScores: currentUser.averageScores,
            numberOfMatches: currentUser.numberOfMatches,
            isUserAnonymous: currentUser.isUserAnonymous
        )
        
        do {
            try db.collection(Constants.userList).document(currentUser.userId).setData(from: newUser)
        } catch {
            fatalError("Adding a study card failed")
        }
        
        return true
    }
    
    func addFriend(friend: FriendsModel, currentUser: ProfileModel) {
        var friendArray: [FriendsModel] = currentUser.friends
        friendArray.append(friend)
        let newUser: ProfileModel = ProfileModel(
            userId: currentUser.userId,
            userName: currentUser.userName,
            userEmail: currentUser.userEmail,
            friends: friendArray,
            createdTime: currentUser.createdTime,
            numberOfWins: currentUser.numberOfWins,
            averageScores: currentUser.averageScores,
            numberOfMatches: currentUser.numberOfMatches,
            isUserAnonymous: currentUser.isUserAnonymous
        )
        
        do {
            try db.collection(Constants.userList).document(currentUser.userId).setData(from: newUser)
        } catch {
            fatalError("Adding a study card failed")
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
    
    func addToInviteList() async throws {
        if let playerID = Auth.auth().currentUser?.uid {
            let player: InviteModel = InviteModel(
                playerID: playerID,
                gameID: "",
                isInviting: false
            )

            try db.collection(Constants.invitedPlayers).document(playerID).setData(from: player)
        }
    }

}
