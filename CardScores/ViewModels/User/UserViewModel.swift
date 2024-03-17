//Created by Halbus Development

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var userRepository = UserRepository()
    @Published var user: [User] = []
    @Published var userName: String
    @Published var userEmail: String
    @Published var userId: String
    @Published var averageScores: Int64
    @Published var friendsMail: [String]
    @Published var friendsName: [String]
    @Published var numberOfMatches: Int64
    @Published var numberOfWins: Int64
    
    init() {

        userName = ""
        userEmail = ""
        userId = ""
        friendsMail = [""]
        friendsName = [""]
        numberOfWins = 0
        numberOfMatches = 0
        averageScores = 0

    }

    func addUsers(_ userModel: UserModel) {
        userRepository.addUser(userModel)
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func addUserFriends(_ myFriend: String) {
        userRepository.addUserFriend(myFriend)
        }
    
    func addWin(_ d: Double, _ friend:String) {
        userRepository.updateWin(1.0, friend)
    }
    
    func addMatches(_ d: Double, _ friend:String) {
        userRepository.updateMatches(1.0, friend)
    }

    func addAverageScores(_ score:Int64, _ friend:String) {
        userRepository.updateScores(score, friend)
    }
    
}
