//Created by Halbus Development

import Foundation
import SwiftUI
import FirebaseAuth

final class MatchFBListViewModel: ObservableObject {
    private var repo: FirebaseRepository
    @Published var matchesFB: [MatchFB] = []
    @Published var saved: Bool = false
    private var userId: String = ""
    
    init() {
        repo = FirebaseRepository()
        getMatches()
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
                      self.matchesFB.append(contentsOf: fetchedItems)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(match: MatchFB) {
        repo.delete(match: match) { error in
            if error == nil {
                self.getMatches()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func add(match: MatchFB) {
        
        let matchToAdd: MatchFB = MatchFB(
            scoreToWin: match.scoreToWin,
            playerOne: match.playerOne,
            playerTwo: match.playerTwo,
            playerThree: match.playerThree,
            playerFour: match.playerFour,
            finalScoreOne: "0",
            finalScoreTwo: "0",
            friendsId: [self.userId],
            myDate: match.myDate,
            registeredUser: match.registeredUser,
            docId: match.docId,
            gameOver: match.gameOver
        )
        
        repo.add(match: matchToAdd) { result in
            switch result {
            case .success(let item):
                DispatchQueue.main.async {
                    self.saved = item == nil ? false : true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
