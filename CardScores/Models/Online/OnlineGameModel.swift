//Created by Halbus Development

import Foundation

struct OnlineGameModel: Identifiable, Codable, Equatable {
    let id: String
    let deckPlayerOne: [CardModel]
    let deckPlayerTwo: [CardModel]
    let deckPlayerThree: [CardModel]
    let deckPlayerFour: [CardModel]
    let deckDiscard: [CardModel]
    let deckSecondOne:[CardModel]
    let deckSecondTwo: [CardModel]
    let deckRefill: [CardModel]
    let playerTurn: String
    
    init(id: String, deckPlayerOne: [CardModel], deckPlayerTwo: [CardModel], deckPlayerThree: [CardModel], deckPlayerFour: [CardModel], deckDiscard: [CardModel], deckSecondOne: [CardModel], deckSecondTwo: [CardModel], deckRefill: [CardModel], playerTurn: String) {
        self.id = id
        self.deckPlayerOne = deckPlayerOne
        self.deckPlayerTwo = deckPlayerTwo
        self.deckPlayerThree = deckPlayerThree
        self.deckPlayerFour = deckPlayerFour
        self.deckDiscard = deckDiscard
        self.deckSecondOne = deckSecondOne
        self.deckSecondTwo = deckSecondTwo
        self.deckRefill = deckRefill
        self.playerTurn = playerTurn
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deckPlayerOne = "deckPlayerOne"
        case deckPlayerTwo = "deckPlayerTwo"
        case deckPlayerThree = "deckPlayerThree"
        case deckPlayerFour = "deckPlayerFour"
        case deckDiscard = "deckDiscard"
        case deckSecondOne = "deckSecondOne"
        case deckSecondTwo = "deckSecondTwo"
        case deckRefill = "deckRefill"
        case playerTurn = "playerTurn"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.deckPlayerOne = try container.decode([CardModel].self, forKey: .deckPlayerOne)
        self.deckPlayerTwo = try container.decode([CardModel].self, forKey: .deckPlayerTwo)
        self.deckPlayerThree = try container.decode([CardModel].self, forKey: .deckPlayerThree)
        self.deckPlayerFour = try container.decode([CardModel].self, forKey: .deckPlayerFour)
        self.deckDiscard = try container.decode([CardModel].self, forKey: .deckDiscard)
        self.deckSecondOne = try container.decode([CardModel].self, forKey: .deckSecondOne)
        self.deckSecondTwo = try container.decode([CardModel].self, forKey: .deckSecondTwo)
        self.deckRefill = try container.decode([CardModel].self, forKey: .deckRefill)
        self.playerTurn = try container.decode(String.self, forKey: .playerTurn)
    }
}
