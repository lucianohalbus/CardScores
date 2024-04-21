//Created by Halbus Development

import Foundation

struct TeamModel: Hashable, Equatable {
    let teamName: String
    let teamId: String
    let playerOne: String
    let playerTwo: String
    let playerOneId: String?
    let PlayerTwoId: String?
    let numberOfMatches: Int
    let numberofWins: Int
    let rating: Double
    
    init(teamName: String, teamId: String, playerOne: String, playerTwo: String, playerOneId: String?, PlayerTwoId: String?, numberOfMatches: Int, numberofWins: Int, rating: Double) {
        self.teamName = teamName
        self.teamId = teamId
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerOneId = playerOneId
        self.PlayerTwoId = PlayerTwoId
        self.numberOfMatches = numberOfMatches
        self.numberofWins = numberofWins
        self.rating = rating
    }
}
