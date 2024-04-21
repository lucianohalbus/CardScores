//Created by Halbus Development

import Foundation

extension RankingView {
    func playerWins(player: String) -> Int {
        var wins: Int = 0
        
        let matchesOver = buracoMatchVM.matchesVM.filter { $0.gameOver }
        
        let teamOneMatches = matchesOver.filter {
            
            $0.playerOne == player || $0.playerTwo == player
        }
        
        let teamOneWins = teamOneMatches.filter {
            Int($0.finalScoreOne) ?? 0 > Int($0.finalScoreTwo) ?? 0
        }
        
        let winsOne = teamOneWins.count
        
        wins = winsOne
        
        
        let teamTwoMatches = matchesOver.filter {
            $0.playerThree == player || $0.playerFour == player
        }
        
        let teamTwoWins = teamTwoMatches.filter {
            Int($0.finalScoreTwo) ?? 0 > Int($0.finalScoreOne) ?? 0
        }.count
        
        wins = winsOne + teamTwoWins
        
        return wins
    }
    
    func playerMatches(player: String) -> Int {
        let matchesOver = buracoMatchVM.matchesVM.filter { $0.gameOver }
        
        return matchesOver.filter {
            $0.playerOne == player ||
            $0.playerTwo == player ||
            $0.playerThree == player ||
            $0.playerFour == player
        }.count

    }
    
    func getPlayerRanking() -> [IndividualRanking] {
        var playerRanking: [IndividualRanking] = []

        for friend in userRepo.listOfFriends {
            let player: IndividualRanking = IndividualRanking(name: friend, matches: playerMatches(player: friend), wins: playerWins(player: friend))
            
            playerRanking.append(player)
        }

        return playerRanking.sorted { $0.wins > $1.wins }
        
    }
    
    func getRating(wins: Int, matches: Int) -> Double {
        let rating = Double(wins) / Double(matches)
        if rating > 0 {
            return rating
        } else {
            return 0
        }
    }

}
