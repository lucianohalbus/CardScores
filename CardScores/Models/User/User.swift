//Created by Halbus Development

import Foundation

struct UserModel: Identifiable, Codable {
    
    let id: String?
    let userName: String
    let userEmail: String
    let userId: String?
    let numberOfWins: Int64
    let averageScores: Int64
    let numberOfMatches: Int64
    let friendsMail: [String]
    let friendsName: [String]
}

