//Created by Halbus Development

import Foundation
import FirebaseFirestore
// Handling the data to be presented at BuracoListView

struct BuracoFBViewModel: Hashable, Identifiable {
    
    let matchFB: MatchFB
    
    var id: String {
        matchFB.id ?? ""
    }
    
    var scoreToWin: String {
        matchFB.scoreToWin
    }
    
    var playerOne: String {
        matchFB.playerOne
    }
    
    var playerTwo: String {
        matchFB.playerTwo
    }
    
    var playerThree: String {
        matchFB.playerThree
    }
    
    var playerFour: String {
        matchFB.playerFour
    }
    
    var finalScoreOne: String {
        matchFB.finalScoreOne
    }
    
    var finalScoreTwo: String {
        matchFB.finalScoreTwo
    }
    
    var friendsId: [String] {
        matchFB.friendsId 
    }
    
    var myDate: Date {
        matchFB.myDate
    }
    
    var registeredUser: Bool {
        matchFB.registeredUser
    }
    
    var docId: String {
        matchFB.docId
    }
    
    var gameOver: Bool {
        matchFB.gameOver
    }

}
