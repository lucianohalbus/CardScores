//Created by Halbus Development

import Foundation

struct IndividualRanking: Hashable, Identifiable {
    let id: String?
    let name: String
    let matches: Int
    let wins: Int
    
    init(id: String?, name: String, matches: Int, wins: Int) {
        self.id = id
        self.name = name
        self.matches = matches
        self.wins = wins
    }
}
