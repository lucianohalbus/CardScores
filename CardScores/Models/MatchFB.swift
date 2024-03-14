//Created by Halbus Development

import Foundation
import SwiftUI
import FirebaseFirestore

struct MatchFB: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    var userId:String?
    var scoreToWin: String
    var playerOne: String
    var playerTwo: String
    var playerThree: String
    var playerFour: String
    var finalScoreOne: String = "0"
    var finalScoreTwo: String = "0"
    var friendsId:[String]?
    @ServerTimestamp var createdTime: Timestamp?
    var myDate: Date
    var registeredUser: Bool
    var docId:String
    var gameOver:Bool 
}
