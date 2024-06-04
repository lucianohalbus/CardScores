//Created by Halbus Development

import Foundation

struct OnlinePlayerModel: Hashable, Codable, Equatable {
    var playerName: String
    var playerID: String
    var playerEmail: String
    var deckPlayer: [CardModel]
    var playerTurn: String
    var onlineScore: Int
    var isInvitedToPlay: Bool?
    var readyToPlay: Bool?
    
    init(playerName: String, playerID: String, playerEmail: String, deckPlayer: [CardModel], playerTurn: String, onlineScore: Int, isInvitedToPlay: Bool? = false, readyToPlay: Bool? = false) {
        self.playerName = playerName
        self.playerID = playerID
        self.playerEmail = playerEmail
        self.deckPlayer = deckPlayer
        self.playerTurn = playerTurn
        self.onlineScore = onlineScore
        self.isInvitedToPlay = isInvitedToPlay
        self.readyToPlay = readyToPlay
    }
    
    enum CodingKeys: String, CodingKey {
        case playerName = "playerName"
        case playerID = "playerID"
        case playerEmail = "playerEmail"
        case deckPlayer = "deckPlayer"
        case playerTurn = "playerTurn"
        case onlineScore = "onlineScore"
        case isInvitedToPlay = "isInvitedToPlay"
        case readyToPlay = "readyToPlay"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.playerName = try container.decode(String.self, forKey: .playerName)
        self.playerID = try container.decode(String.self, forKey: .playerID)
        self.playerEmail = try container.decode(String.self, forKey: .playerEmail)
        self.deckPlayer = try container.decode([CardModel].self, forKey: .deckPlayer)
        self.playerTurn = try container.decode(String.self, forKey: .playerTurn)
        self.onlineScore = try container.decode(Int.self, forKey: .onlineScore)
        self.isInvitedToPlay = try container.decode(Bool.self, forKey: .isInvitedToPlay)
        self.readyToPlay = try container.decode(Bool.self, forKey: .readyToPlay)
    }

}
