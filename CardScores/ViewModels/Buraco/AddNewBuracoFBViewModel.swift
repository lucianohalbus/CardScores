//Created by Halbus Development

import Foundation
import FirebaseAuth

final class AddNewBuracoFBViewModel: ObservableObject {
    @Published var repo: BuracoFirebaseRepository
    @Published var playerOne: String = ""
    @Published var playerTwo: String = ""
    @Published var playerThree: String = ""
    @Published var playerFour: String = ""
    @Published var targetScore: String = ""
    @Published var addNewSaved: Bool = false
    @Published var userId: String = ""
    
    init() {
        repo = BuracoFirebaseRepository()
        getUserId()
    }
    
    func getUserId() {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func add() {
        if !userId.isEmpty {
            repo.add(match: MatchFB(scoreToWin: targetScore, playerOne: playerOne, playerTwo: playerTwo, playerThree: playerThree, playerFour: playerFour, finalScoreOne: "0", finalScoreTwo: "0", friendsId: [userId], myDate: Date(), registeredUser: false, docId: "", gameOver: false)) { result in
                switch result {
                case .success(let item):
                    DispatchQueue.main.async {
                        self.addNewSaved = item == nil ? false : true
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
