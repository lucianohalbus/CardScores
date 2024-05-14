//Created by Halbus Development

import Foundation
import FirebaseFirestore

struct FriendsModel: Codable, Hashable {
    let friendId: String
    let friendEmail: String
    let friendName: String
    
    init(friendId: String, friendEmail: String, friendName: String) {
        self.friendId = friendId
        self.friendEmail = friendEmail
        self.friendName = friendName
    }
    
    enum CodingKeys: String, CodingKey {
        case friendId = "friendId"
        case friendEmail = "friendEmail"
        case friendName = "friendName"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.friendId = try container.decode(String.self, forKey: .friendId)
        self.friendEmail = try container.decode(String.self, forKey: .friendEmail)
        self.friendName = try container.decode(String.self, forKey: .friendName)
    }

}
