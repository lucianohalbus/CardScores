//Created by Halbus Development

import Foundation

struct OnlinePlayerModel: Hashable, Codable, Equatable {
    var gameID: String
    var playerName: String
    var playerID: String
    var playerEmail: String
    var deckPlayer: [CardModel]
    var playerTurn: String
    var onlineScore: Int?
    
    init(gameID: String, playerName: String, playerID: String, playerEmail: String, deckPlayer: [CardModel], playerTurn: String, onlineScore: Int? = nil) {
        self.gameID = gameID
        self.playerName = playerName
        self.playerID = playerID
        self.playerEmail = playerEmail
        self.deckPlayer = deckPlayer
        self.playerTurn = playerTurn
        self.onlineScore = onlineScore
    }
    
    enum CodingKeys: String, CodingKey {
        case gameID = "gameID"
        case playerName = "playerName"
        case playerID = "playerID"
        case playerEmail = "playerEmail"
        case deckPlayer = "deckPlayer"
        case playerTurn = "playerTurn"
        case onlineScore = "onlineScore"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gameID = try container.decode(String.self, forKey: .gameID)
        self.playerName = try container.decode(String.self, forKey: .playerName)
        self.playerID = try container.decode(String.self, forKey: .playerID)
        self.playerEmail = try container.decode(String.self, forKey: .playerEmail)
        self.deckPlayer = try container.decode([CardModel].self, forKey: .deckPlayer)
        self.playerTurn = try container.decode(String.self, forKey: .playerTurn)
        self.onlineScore = try container.decode(Int.self, forKey: .onlineScore)
    }
    
   
}
