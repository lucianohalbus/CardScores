//Created by Halbus Development

import Foundation

struct OnlineBuracoModel: Identifiable, Codable, Equatable {
    var id: String
    var deckDiscard: [CardModel]
    var deckSecondOne:[CardModel]
    var deckSecondTwo: [CardModel]
    var deckRefill: [CardModel]
    var playerOne: OnlinePlayerModel
    var playerTwo: OnlinePlayerModel
    var playerThree: OnlinePlayerModel
    var playerFour: OnlinePlayerModel
    var playerTurn: String
    var isPlayerOneTurn: Bool
    var isPlayerTwoTurn: Bool
    var isPlayerThreeTurn: Bool
    var isPlayerFourTurn: Bool
    var playersID: [String]
    
    init(id: String, deckDiscard: [CardModel], deckSecondOne: [CardModel], deckSecondTwo: [CardModel], deckRefill: [CardModel], playerOne: OnlinePlayerModel, playerTwo: OnlinePlayerModel,  playerThree: OnlinePlayerModel,  playerFour: OnlinePlayerModel,  playerTurn: String, isPlayerOneTurn: Bool, isPlayerTwoTurn: Bool, isPlayerThreeTurn: Bool, isPlayerFourTurn: Bool, playersID: [String]) {
        self.id = id
        self.deckDiscard = deckDiscard
        self.deckSecondOne = deckSecondOne
        self.deckSecondTwo = deckSecondTwo
        self.deckRefill = deckRefill
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerThree = playerThree
        self.playerFour = playerFour
        self.playerTurn = playerTurn
        self.isPlayerOneTurn = isPlayerOneTurn
        self.isPlayerTwoTurn = isPlayerTwoTurn
        self.isPlayerThreeTurn = isPlayerThreeTurn
        self.isPlayerFourTurn = isPlayerFourTurn
        self.playersID = playersID
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deckDiscard = "deckDiscard"
        case deckSecondOne = "deckSecondOne"
        case deckSecondTwo = "deckSecondTwo"
        case deckRefill = "deckRefill"
        case playerTurn = "playerTurn"
        case playerOne = "playerOne"
        case playerTwo = "playerTwo"
        case playerThree = "playerThree"
        case playerFour = "playerFour"
        case isPlayerOneTurn = "isPlayerOneTurn"
        case isPlayerTwoTurn = "isPlayerTwoTurn"
        case isPlayerThreeTurn = "isPlayerThreeTurn"
        case isPlayerFourTurn = "isPlayerFourTurn"
        case playersID = "playersID"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.deckDiscard = try container.decode([CardModel].self, forKey: .deckDiscard)
        self.deckSecondOne = try container.decode([CardModel].self, forKey: .deckSecondOne)
        self.deckSecondTwo = try container.decode([CardModel].self, forKey: .deckSecondTwo)
        self.deckRefill = try container.decode([CardModel].self, forKey: .deckRefill)
        self.playerOne = try container.decode(OnlinePlayerModel.self, forKey: .playerOne)
        self.playerTwo = try container.decode(OnlinePlayerModel.self, forKey: .playerTwo)
        self.playerThree = try container.decode(OnlinePlayerModel.self, forKey: .playerThree)
        self.playerFour = try container.decode(OnlinePlayerModel.self, forKey: .playerFour)
        self.playerTurn = try container.decode(String.self, forKey: .playerTurn)
        self.isPlayerOneTurn = try container.decode(Bool.self, forKey: .isPlayerOneTurn)
        self.isPlayerTwoTurn = try container.decode(Bool.self, forKey: .isPlayerTwoTurn)
        self.isPlayerThreeTurn = try container.decode(Bool.self, forKey: .isPlayerThreeTurn)
        self.isPlayerFourTurn = try container.decode(Bool.self, forKey: .isPlayerFourTurn) 
        self.playersID = try container.decode([String].self, forKey: .playersID)
    }
}
