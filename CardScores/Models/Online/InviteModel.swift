//Created by Halbus Development

import Foundation

struct InviteModel: Codable {
    var playerID: String
    var gameID: String
    var isInviting: Bool
    
    init(playerID: String, gameID: String, isInviting: Bool) {
        self.playerID = playerID
        self.gameID = gameID
        self.isInviting = isInviting
    }
    
    enum CodingKeys: String, CodingKey {
        case playerID = "playerID"
        case gameID = "gameID"
        case isInviting = "isInviting"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerID = try container.decode(String.self, forKey: .playerID)
        self.gameID = try container.decode(String.self, forKey: .gameID)
        self.isInviting = try container.decode(Bool.self, forKey: .isInviting)
    }
    
}
