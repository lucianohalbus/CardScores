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
    var isPlayerOneInvited: Bool
    var isPlayerTwoInvited: Bool
    var isPlayerThreeInvited: Bool
    var isPlayerFourInvited: Bool
    var playersID: [String]
    
    init(id: String, deckDiscard: [CardModel], deckSecondOne: [CardModel], deckSecondTwo: [CardModel], deckRefill: [CardModel], playerOne: OnlinePlayerModel, playerTwo: OnlinePlayerModel,  playerThree: OnlinePlayerModel,  playerFour: OnlinePlayerModel,  playerTurn: String, isPlayerOneInvited: Bool, isPlayerTwoInvited: Bool, isPlayerThreeInvited: Bool, isPlayerFourInvited: Bool, playersID: [String]) {
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
        self.isPlayerOneInvited = isPlayerOneInvited
        self.isPlayerTwoInvited = isPlayerTwoInvited
        self.isPlayerThreeInvited = isPlayerThreeInvited
        self.isPlayerFourInvited = isPlayerFourInvited
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
        case isPlayerOneInvited = "isPlayerOneInvited"
        case isPlayerTwoInvited = "isPlayerTwoInvited"
        case isPlayerThreeInvited = "isPlayerThreeInvited"
        case isPlayerFourInvited = "isPlayerFourInvited"
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
        self.isPlayerOneInvited = try container.decode(Bool.self, forKey: .isPlayerOneInvited)
        self.isPlayerTwoInvited = try container.decode(Bool.self, forKey: .isPlayerTwoInvited)
        self.isPlayerThreeInvited = try container.decode(Bool.self, forKey: .isPlayerThreeInvited)
        self.isPlayerFourInvited = try container.decode(Bool.self, forKey: .isPlayerFourInvited) 
        self.playersID = try container.decode([String].self, forKey: .playersID)
    }
}
