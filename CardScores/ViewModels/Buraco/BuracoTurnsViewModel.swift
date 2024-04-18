//Created by Halbus Development

import Foundation

final class BuracoTurnsViewModel: ObservableObject {
    var repo: BuracoTurnsRepository
    @Published var turns: [MatchTurn] = []
    
    // MatchTurn
    @Published var myTime: Date = Date()
    @Published var scoresTurnOne: String = ""
    @Published var scoresTurnTwo: String = ""
    @Published var turnId: String = ""
    @Published var friendsId: [String] = []
    @Published var calculatedScoreOne: Int = 0
    @Published var calculatedScoreTwo: Int = 0
    
    init() {
        repo = BuracoTurnsRepository()
    }
    
    func getTurn(matchId: String) {
        repo.getTurns { result in
            switch result {
            case .success(let fetchedItems):
                if let fetchedItems = fetchedItems {
                    self.turns.removeAll()
                    DispatchQueue.main.async {
                        self.turns = fetchedItems.filter { $0.turnId == matchId }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addTurn(matchTurn: MatchTurn) {
        repo.addTurn(matchTurn: matchTurn) { result in
            switch result {
            case .success(_):
                print("Successfully Added")
                self.getTurn(matchId: matchTurn.turnId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func calculatePartialScore(canastraScore: Int, cardScore: Int, negativeScore: Int, goodDistributor: Bool) -> Int {
        let partialScore = (canastraScore + cardScore - negativeScore)
        
        if goodDistributor {
            return partialScore + 100
        }
        return partialScore
    }
    
    func calculateTotalScore(dbScore: Int, canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        var partialScore: Int =  (canastraScore + cardScore - negativeScore)
        return partialScore + dbScore
    }

}
