//Created by Halbus Development

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var userRepo: UserRepository
    @Published var userProfile: ProfileModel
    @Published var isUserAnonymous: Bool = false
    @Published var userUpdated: Bool = false
    
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
            numberOfMatches: 0,
            isUserAnonymous: false
        )

    }
    
    @MainActor
    func getUser() async throws -> ProfileModel {
        guard let userID = Auth.auth().currentUser?.uid else {
            throw URLError(.badServerResponse)
        }

        self.userProfile = await userRepo.getUserList(userId: userID)
        
        self.isUserAnonymous = userProfile.isUserAnonymous
        
        return userProfile

    }
    
    @MainActor
    func addFriends(friendId: String, currentUser: ProfileModel) async {
        
        let userFriend: ProfileModel = await userRepo.getUserList(userId: friendId)
        
        let friendModel: FriendsModel = FriendsModel(
            friendId: userFriend.userId,
            friendEmail: userFriend.userEmail,
            friendName: userFriend.userName
        )
        
        userRepo.addFriend(friend: friendModel, currentUser: currentUser)

    }
    
    @MainActor
    func removeFriends(friend: FriendsModel, currentUser: ProfileModel) async {
        let friendRemoved: Bool = userRepo.removeFriend(friend: friend, currentUser: currentUser)
        
        if friendRemoved {
            self.userUpdated = true
        }

    }
    
}
