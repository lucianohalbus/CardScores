//Created by Halbus Development

import Foundation

struct ProfileModel: Codable {
    let userId: String
    let userName: String
    let userEmail: String
    let friends: [FriendsModel]
    let createdTime: Date
    let numberOfWins: Int
    let averageScores: Int
    let numberOfMatches: Int
    
    init(userId: String, userName: String, userEmail: String, friends: [FriendsModel], createdTime: Date, numberOfWins: Int, averageScores: Int, numberOfMatches: Int) {
        self.userId = userId
        self.userName = userName
        self.userEmail = userEmail
        self.friends = friends
        self.createdTime = createdTime
        self.numberOfWins = numberOfWins
        self.averageScores = averageScores
        self.numberOfMatches = numberOfMatches
    }

}
