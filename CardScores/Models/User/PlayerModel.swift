//Created by Halbus Development


import Foundation

struct PlayerModel: Hashable, Identifiable, Equatable {
    let id: String?
    let player: String
    let numberOfMatches: Int
    let numberofWins: Int
    let rating: Double
    
    init(id: String?, player: String, numberOfMatches: Int, numberofWins: Int, rating: Double) {
        self.id = id
        self.player = player
        self.numberOfMatches = numberOfMatches
        self.numberofWins = numberofWins
        self.rating = rating
    }
}
