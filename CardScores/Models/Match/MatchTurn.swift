// Created by Halbus Development
// March 10th, 2024

import FirebaseFirestore
import Foundation

struct MatchTurn: Identifiable, Hashable, Codable {
    
    var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    var myTime: Date
    var scoresTurnOne: String
    var scoresTurnTwo: String
    var turnId: String
    var friendsId: [String]
    
    init(id: String? = nil, createdTime: Timestamp? = nil, myTime: Date, scoresTurnOne: String, scoresTurnTwo: String, turnId: String, friendsId: [String]) {
        self.id = id
        self.createdTime = createdTime
        self.myTime = myTime
        self.scoresTurnOne = scoresTurnOne
        self.scoresTurnTwo = scoresTurnTwo
        self.turnId = turnId
        self.friendsId = friendsId
    }
    
}
