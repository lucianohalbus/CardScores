//Created by Halbus Development

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var userRepo = UserRepository()
    @Published var userName: String
    @Published var userEmail: String
    @Published var userId: String
    @Published var averageScores: Int64
    @Published var friendsMail: [String]
    @Published var friendsName: [String]
    @Published var numberOfMatches: Int64
    @Published var numberOfWins: Int64
    @Published var userProfile: ProfileModel
    
    init() {

        userName = ""
        userEmail = ""
        userId = ""
        friendsMail = [""]
        friendsName = [""]
        numberOfWins = 0
        numberOfMatches = 0
        averageScores = 0
        
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
    
    
    func getUser() async throws -> ProfileModel {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            throw URLError(.badServerResponse)
        }

        let currentUser: ProfileModel = await userRepo.getUserList(userId: userID)
        return currentUser
    }
    
    
    
    
    
    
    
    
    func getUserList() async {
        if let userId = Auth.auth().currentUser?.uid {
            self.userProfile = await userRepo.getUserList(userId: userId)
        }
    }

    func addUsers(_ userModel: UserModel) {
        userRepo.addUser(userModel)
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func addFriends(friend: String) {
        userRepo.addFriend(friend: friend)
        }
    
    func addWin(_ d: Double, _ friend:String) {
        userRepo.updateWin(1.0, friend)
    }
    
    func addMatches(_ d: Double, _ friend:String) {
        userRepo.updateMatches(1.0, friend)
    }

    func addAverageScores(_ score:Int64, _ friend:String) {
        userRepo.updateScores(score, friend)
    }
    
}
