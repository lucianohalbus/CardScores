//Created by Halbus Development

import Foundation

struct ProfileModel {
    let userName: String
    let userEmail: String
    let userId: String?
    let friendsMail: [String]
    let friendsName: [String]
    let createdTime: Date
    
    init(userName: String, userEmail: String, userId: String?, friendsMail: [String], friendsName: [String], createdTime: Date) {
        self.userName = userName
        self.userEmail = userEmail
        self.userId = userId
        self.friendsMail = friendsMail
        self.friendsName = friendsName
        self.createdTime = createdTime
    }
    
    
}
