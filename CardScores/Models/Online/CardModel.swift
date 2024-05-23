//Created by Halbus Development

import Foundation

struct CardModel: Identifiable, Hashable, Codable, Equatable {
    let id: String
    let cardCode: String
    let value: Int
    var backColor: String
    
    init(id: String, cardCode: String, value: Int, backColor: String) {
        self.id = id
        self.cardCode = cardCode
        self.value = value
        self.backColor = backColor
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cardCode = "cardCode"
        case value = "value"
        case backColor = "backColor"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.cardCode = try container.decode(String.self, forKey: .cardCode)
        self.value = try container.decode(Int.self, forKey: .value)
        self.backColor = try container.decode(String.self, forKey: .backColor)
    }
}
