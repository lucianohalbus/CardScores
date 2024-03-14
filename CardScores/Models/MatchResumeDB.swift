// Created by Halbus Development
// March 10th, 2024

import Foundation

final class MatchResumeDB {
    var date: Date
    var partialScoreTeamOne: Int
    var partialScoreTeamTwo: Int
    
    init(date: Date, partialScoreTeamOne: Int, partialScoreTeamTwo: Int) {
        self.date = date
        self.partialScoreTeamOne = partialScoreTeamOne
        self.partialScoreTeamTwo = partialScoreTeamTwo
    }
    
}
