//Created by Halbus Development

import Foundation

struct ProfileModel: Codable, Hashable {
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
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case userName = "userName"
        case userEmail = "userEmail"
        case friends = "friends"
        case createdTime = "createdTime"
        case numberOfWins = "numberOfWins"
        case averageScores = "averageScores"
        case numberOfMatches = "numberOfMatches"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userEmail = try container.decode(String.self, forKey: .userEmail)
        self.friends = try container.decode([FriendsModel].self, forKey: .friends)
        self.createdTime = try container.decode(Date.self, forKey: .createdTime)
        self.numberOfWins = try container.decode(Int.self, forKey: .numberOfWins)
        self.averageScores = try container.decode(Int.self, forKey: .averageScores)
        self.numberOfMatches = try container.decode(Int.self, forKey: .numberOfMatches)
    }

}
