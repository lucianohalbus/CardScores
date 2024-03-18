//Created by Halbus Development

import Foundation

final class BuracoTurnsViewModel: ObservableObject {
    var repo: BuracoTurnsRepository
   @Published var turns: [MatchTurn] = []
    
   @Published var myTime: Date = Date()
   @Published var scoresTurnOne: String = ""
   @Published var scoresTurnTwo: String = ""
   @Published var turnId: String = ""
   @Published var friendsId: [String] = []
    
   @Published var playerOne: String = ""
   @Published var playerTwo: String = ""
   @Published var playerThree: String = ""
   @Published var playerFour: String = ""
   @Published var finalScoreTeamOne: Int? = nil
   @Published var finalScoreTeamTwo: Int? = nil
   @Published var targetScore: Int? = nil
   @Published var cardScoreOne: Int? = nil
   @Published var canastraScoreOne: Int? = nil
   @Published var negativeScoreOne: Int? = nil
   @Published var cardScoreTwo: Int? = nil
   @Published var canastraScoreTwo: Int? = nil
   @Published var negativeScoreTwo: Int? = nil
   @Published var gameOver: Bool = false
    
    init() {
        repo = BuracoTurnsRepository()
    }
    
    func getTurn() {
        repo.getTurns { result in
            switch result {
            case .success(let fetchedItems):
                if let fetchedItems = fetchedItems {
                    DispatchQueue.main.async {
                        self.turns.removeAll()
                        self.turns.append(contentsOf: fetchedItems)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addTurn(turn: MatchTurn) {
        repo.addTurn(matchTurn:
            MatchTurn(
                myTime: self.myTime,
                scoresTurnOne: String(calculateTotalScore(
                    dbScore: self.finalScoreTeamOne ?? 0,
                    canastraScore: self.canastraScoreOne ?? 0,
                    cardScore: self.cardScoreOne ?? 0,
                    negativeScore: self.negativeScoreOne ?? 0
                )),
                scoresTurnTwo: String(calculateTotalScore(
                    dbScore: self.finalScoreTeamTwo ?? 0,
                    canastraScore: self.canastraScoreTwo ?? 0,
                    cardScore: self.cardScoreTwo ?? 0,
                    negativeScore: self.negativeScoreTwo ?? 0
                )),
                turnId: self.turnId, 
                friendsId: self.friendsId
            )) { result in

            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.getTurn()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func calculatePartialScore(canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        return (canastraScore + cardScore - negativeScore)
        
    }
    
    private func calculateTotalScore(dbScore: Int, canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        let partialScore: Int =  (canastraScore + cardScore - negativeScore)
        return partialScore + dbScore
    }
}
