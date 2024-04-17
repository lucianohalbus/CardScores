//Created by Halbus Development

import Foundation
import FirebaseAuth

final class BuracoMatchViewModel: ObservableObject {
    @Published var buracoRepo: BuracoMatchesRepository
    @Published var matchesVM: [BuracoFBViewModel] = []
    @Published var saved: Bool = false

    @Published var addNewSaved: Bool = false
    @Published var userId: String = ""
    @Published var scoreOne: String = ""
    @Published var scoreTwo: String = ""
    @Published var playersOfTheMatch: [String] = []
    @Published var isMatchRecreated: Bool = false
    

    @Published var createdItem: MatchFB = MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [], myDate: Date(), registeredUser: false, docId: "", gameOver: false)
    
    // MatchFB
    @Published var id: String?
    @Published var scoreToWin: String = "3000"
    @Published var playerOne: String = ""
    @Published var playerTwo: String = ""
    @Published var playerThree: String = ""
    @Published var playerFour: String = ""
    @Published var finalScoreOne: String = "0"
    @Published var finalScoreTwo: String = "0"
    @Published var friendsId:[String] = []
    @Published var myDate: Date = Date()
    @Published var registeredUser: Bool = false
    @Published var docId:String = ""
    @Published var gameOver:Bool = false
    @Published var profileImagePathUrl: URL? = nil
    @Published var imagePath: String?
    @Published var imagePathUrl: String?
    
    init() {
        buracoRepo = BuracoMatchesRepository()
        getUserId()
    }
    
    func getUserId() {
        if let userId = Auth.auth().currentUser?.uid {
            self.userId = userId
        }
    }
    
    func getMatches() {
        buracoRepo.get { result in
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
        buracoRepo.delete(item: MatchFB(id: matchFB.id, scoreToWin: matchFB.scoreToWin, playerOne: matchFB.playerOne, playerTwo: matchFB.playerTwo, playerThree: matchFB.playerThree, playerFour: matchFB.playerFour, finalScoreOne: matchFB.finalScoreOne, finalScoreTwo: matchFB.finalScoreTwo, friendsId: matchFB.friendsId, myDate: matchFB.myDate, registeredUser: matchFB.registeredUser, docId: matchFB.docId, gameOver: matchFB.gameOver)) { error in
            if error == nil {
                self.getMatches()
                
            } else {
                print(error?.localizedDescription ?? "The Match was not deleted.")
            }
        }
    }
    
    func update(matchId: String, matchFB: MatchFB) {
        buracoRepo.update(matchId: matchId, matchFB: matchFB) { result in
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
    
    func add() {
        if !userId.isEmpty {
            buracoRepo.add(match: MatchFB(scoreToWin: scoreToWin, playerOne: playerOne, playerTwo: playerTwo, playerThree: playerThree, playerFour: playerFour, finalScoreOne: "0", finalScoreTwo: "0", friendsId: [userId], myDate: Date(), registeredUser: false, docId: "", gameOver: false)) { result in
                switch result {
                case .success(let item):
                if let item = item {
                    self.createdItem = item
                    
                    DispatchQueue.main.async {
                        self.addNewSaved = true
                    }
                }
  
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func recreateMatch(matchFB: MatchFB) {
        if !userId.isEmpty {
            buracoRepo.add(match: matchFB) { result in
                switch result {
                case .success(let item):
                if let item = item {
                    self.createdItem = item
                    
                    DispatchQueue.main.async {
                        self.isMatchRecreated = true
                    }
                }
  
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

