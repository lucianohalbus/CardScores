//Created by Halbus Development

import Foundation
import SwiftUI
import FirebaseAuth
//
final class BuracoListViewModel: ObservableObject {
    private var repo: BuracoFirebaseRepository
    @Published var matchesFB: [MatchFB] = []
    @Published var matchesVM: [BuracoFBViewModel] = []
    @Published var saved: Bool = false
    private var userId: String = ""
    
    
    var maches: [BuracoFBViewModel] {
        return matchesVM
    }
    
    init() {
        repo = BuracoFirebaseRepository()
//        getMatches()
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
//                        self.matchesFB.append(contentsOf: fetchedItems)
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
                print(error?.localizedDescription)
            }
        }
    }
    
//    func delete(match: MatchFB, index: Int) {
//        repo.delete(match: match) { error in
//            if error == nil {
//                DispatchQueue.main.async {
//                    self.getMatches()
//                }
//            } else {
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
    
    func add(match: MatchFB) {
        repo.add(match: match) { error in
            if error == nil {
                self.getMatches()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
}
