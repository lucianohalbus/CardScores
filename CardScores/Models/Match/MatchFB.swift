//Created by Halbus Development

import Foundation
import FirebaseFirestore

struct MatchFB: Identifiable, Hashable, Codable {
    
    var id: String?
    var scoreToWin: String
    var playerOne: String
    var playerTwo: String
    var playerThree: String
    var playerFour: String
    var finalScoreOne: String = "0"
    var finalScoreTwo: String = "0"
    var friendsId:[String] = []
    @ServerTimestamp var createdTime: Timestamp?
    var myDate: Date
    var registeredUser: Bool
    var docId:String
    var gameOver:Bool
    var profileImagePathUrl: URL? = nil
    var imagePath: String?
    var imagePathUrl: String?
    
    init(id: String? = nil, scoreToWin: String, playerOne: String, playerTwo: String, playerThree: String, playerFour: String, finalScoreOne: String, finalScoreTwo: String, friendsId: [String], createdTime: Timestamp? = nil, myDate: Date, registeredUser: Bool, docId: String, gameOver: Bool, profileImagePathUrl: URL? = nil, imagePath: String? = nil, imagePathUrl: String? = nil) {
        self.id = id
        self.scoreToWin = scoreToWin
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerThree = playerThree
        self.playerFour = playerFour
        self.finalScoreOne = finalScoreOne
        self.finalScoreTwo = finalScoreTwo
        self.friendsId = friendsId
        self.createdTime = createdTime
        self.myDate = myDate
        self.registeredUser = registeredUser
        self.docId = docId
        self.gameOver = gameOver
        self.profileImagePathUrl = profileImagePathUrl
        self.imagePath = imagePath
        self.imagePathUrl = imagePathUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case scoreToWin = "scoreToWin"
        case playerOne = "playerOne"
        case playerTwo = "playerTwo"
        case playerThree = "playerThree"
        case playerFour = "playerFour"
        case finalScoreOne = "finalScoreOne"
        case finalScoreTwo = "finalScoreTwo"
        case friendsId = "friendsId"
        case createdTime = "createdTime"
        case myDate = "myDate"
        case registeredUser = "registeredUser"
        case docId = "docId"
        case gameOver = "gameOver"
        case profileImagePathUrl = "profileImagePathUrl"
        case imagePath = "image_path"
        case imagePathUrl = "image_path_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.scoreToWin = try container.decode(String.self, forKey: .scoreToWin)
        self.playerOne = try container.decode(String.self, forKey: .playerOne)
        self.playerTwo = try container.decode(String.self, forKey: .playerTwo)
        self.playerThree = try container.decode(String.self, forKey: .playerThree)
        self.playerFour = try container.decode(String.self, forKey: .playerFour)
        self.finalScoreOne = try container.decode(String.self, forKey: .finalScoreOne)
        self.finalScoreTwo = try container.decode(String.self, forKey: .finalScoreTwo)
        self.friendsId = try container.decode([String].self, forKey: .friendsId)
        self._createdTime = try container.decode(ServerTimestamp<Timestamp>.self, forKey: .createdTime)
        self.myDate = try container.decode(Date.self, forKey: .myDate)
        self.registeredUser = try container.decode(Bool.self, forKey: .registeredUser)
        self.docId = try container.decode(String.self, forKey: .docId)
        self.gameOver = try container.decode(Bool.self, forKey: .gameOver)
        self.profileImagePathUrl = try container.decodeIfPresent(URL.self, forKey: .profileImagePathUrl)
        self.imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath)
        self.imagePathUrl = try container.decodeIfPresent(String.self, forKey: .imagePathUrl)
    }
    
}
