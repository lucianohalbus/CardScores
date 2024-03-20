//Created by Halbus Development

// handling data from and to Firestore

import Foundation
import FirebaseAuth

final class BuracoListViewModel: ObservableObject {
    private var repo: BuracoMatchesRepository
    @Published var matchesVM: [BuracoFBViewModel] = []
    private var userId: String = ""
    @Published var saved: Bool = false
    @Published var scoreOne: String = ""
    @Published var scoreTwo: String = ""
    @Published var gameOver: Bool = false
    
    init() {
        repo = BuracoMatchesRepository()
        getUserId()
    }
    
    func getUserId() {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func getMatches() {
        repo.get { result in
            switch result {
            case .success(let fetchedItems):
                if let fetchedItems = fetchedItems {
                    DispatchQueue.main.async {
                        self.matchesVM = fetchedItems.map(BuracoFBViewModel.init)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(matchFB: BuracoFBViewModel) {
        repo.delete(item: MatchFB(id: matchFB.id, scoreToWin: matchFB.scoreToWin, playerOne: matchFB.playerOne, playerTwo: matchFB.playerTwo, playerThree: matchFB.playerThree, playerFour: matchFB.playerFour, myDate: matchFB.myDate, registeredUser: matchFB.registeredUser, docId: matchFB.docId, gameOver: matchFB.gameOver)) { error in
            if error == nil {
                self.getMatches()
                
                
                
            } else {
                print(error?.localizedDescription ?? "The Match was not deleted.")
            }
        }
    }
    
    func update(matchId: String, matchFB: MatchFB) {
        repo.update(matchId: matchId, matchFB: matchFB) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.saved = success
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
