//Created by Halbus Development

import Foundation
import FirebaseFirestore

struct FriendsModel: Codable, Hashable {
    let friendId: String
    let friendEmail: String
    let friendName: String

}

struct UserModel: Identifiable, Codable {
    let id: String?
    let userName: String
    let userEmail: String
    let userId: String?
    let numberOfWins: Int64
    let averageScores: Int64
    let numberOfMatches: Int64
    let friendsMail: [String]
    let friendsName: [String]
    
    
    init(id: String?, userName: String, userEmail: String, userId: String?, numberOfWins: Int64, averageScores: Int64, numberOfMatches: Int64, friendsMail: [String], friendsName: [String]) {
        self.id = id
        self.userName = userName
        self.userEmail = userEmail
        self.userId = userId
        self.numberOfWins = numberOfWins
        self.averageScores = averageScores
        self.numberOfMatches = numberOfMatches
        self.friendsMail = friendsMail
        self.friendsName = friendsName
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "userName"
        case userEmail = "userEmail"
        case userId = "userId"
        case numberOfWins = "numberOfWins"
        case averageScores = "averageScores"
        case numberOfMatches = "numberOfMatches"
        case friendsMail = "friendsMail"
        case friendsName = "friendsName"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.userEmail = try container.decode(String.self, forKey: .userEmail)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.numberOfWins = try container.decode(Int64.self, forKey: .numberOfWins)
        self.averageScores = try container.decode(Int64.self, forKey: .averageScores)
        self.numberOfMatches = try container.decode(Int64.self, forKey: .numberOfMatches)
        self.friendsMail = try container.decode([String].self, forKey: .friendsMail)
        self.friendsName = try container.decode([String].self, forKey: .friendsName)
    }
  
}



