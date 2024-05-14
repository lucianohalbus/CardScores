//Created by Halbus Development

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var userRepo: UserRepository
    @Published var userProfile: ProfileModel
    @Published var isUserAnonymous: Bool = false
    
    init() {
        
        userRepo = UserRepository()

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

    }
    
    @MainActor
    func getUser() async throws -> ProfileModel {
        guard let userID = Auth.auth().currentUser?.uid else {
            self.isUserAnonymous = true
            throw URLError(.badServerResponse)
            
        }

        self.userProfile = await userRepo.getUserList(userId: userID)
        
        return userProfile

    }
    
    func addFriends(friendId: String, currentUser: ProfileModel) async {
        
        let userFriend: ProfileModel = await userRepo.getUserList(userId: friendId)
        
        let friendModel: FriendsModel = FriendsModel(
            friendId: userFriend.userId,
            friendEmail: userFriend.userEmail,
            friendName: userFriend.userName
        )
        
        userRepo.addFriend(friend: friendModel, currentUser: currentUser)
       
        
    }
    
    
    
    
    
    
    
    
//    func getUserList() async {
//        if let userId = Auth.auth().currentUser?.uid {
//            let user = await userRepo.getUserList(userId: userId)
//            DispatchQueue.main.async {
//                self.userProfile = user
//            }
//        }
//    }

//    func addUsers(_ userModel: UserModel) {
//        userRepo.addUser(userModel)
//    }
//    
//    var isSignedIn: Bool {
//        return Auth.auth().currentUser != nil
//    }
//    
//    func addFriends(friend: String) {
//        userRepo.addFriend(friend: friend)
//        }
//    
//    func addWin(_ d: Double, _ friend:String) {
//        userRepo.updateWin(1.0, friend)
//    }
//    
//    func addMatches(_ d: Double, _ friend:String) {
//        userRepo.updateMatches(1.0, friend)
//    }
//
//    func addAverageScores(_ score:Int64, _ friend:String) {
//        userRepo.updateScores(score, friend)
//    }
    
}
