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
    
    func addTurn(matchTurn: MatchTurn) {
        repo.addTurn(matchTurn: matchTurn) { result in

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
    
    func calculatePartialScore(canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        return (canastraScore + cardScore - negativeScore)
        
    }
    
    func calculateTotalScore(dbScore: Int, canastraScore: Int, cardScore: Int, negativeScore: Int) -> Int {
        let partialScore: Int =  (canastraScore + cardScore - negativeScore)
        return partialScore + dbScore
    }

}
