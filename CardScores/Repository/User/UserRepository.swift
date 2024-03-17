//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class UserRepository: ObservableObject {
    private let path:String = "User"
    private let db = Firestore.firestore()
    @Published var userModel: [UserModel] = []

    init() {

       get()

    }
    
    func get() {
        if let myEmail = Auth.auth().currentUser?.email {
        db.collection(path)
            .order(by: "numberOfWins", descending: true)
            .whereField("friendsMail", arrayContains: myEmail)
            .addSnapshotListener{ (snapshot, error) in
                if let snapshot = snapshot {
                    self.userModel = snapshot.documents.compactMap { document in
                        do {
                            let x = try document.data(as: UserModel.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
        }
    }
    
    
    func addUser(_ userModel: UserModel) {
        if let userId = Auth.auth().currentUser?.uid {
            do {
                _ = try db.collection(path).document(userId).setData(from: userModel)
            } catch {
                fatalError("Adding a study card failed")
            }
        }
    }
    
    
    func removeUser(_ userModel: UserModel) {
        if let scoreModelID = userModel.id {
            db.collection(path).document(scoreModelID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    
    func updateUser(_ userModel: UserModel) {
        guard let documentID = userModel.id else { return }
        do {
            try db.collection(path).document(documentID).setData(from:
                                                                    userModel)
        } catch {
            fatalError("Adding a study card failed")
        }
    }
    
    
    func addUserFriend(_ myFriend:String) {
        if let userId = Auth.auth().currentUser?.uid {
            let friendRef = db.collection("User").document(userId)
            friendRef.updateData([
                "friendsMail": FieldValue.arrayUnion([myFriend])
            ])
        }
    }
    
    
    func updateRankingFriends(_ emailFriend:String, scoreFriend:Double) {
        db.collection("User")
            .whereField("userEmail", isEqualTo: emailFriend)
        
    }
    
    
    func updateWin(_ d: Double, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["numberOfWins": FieldValue.increment(1.0)])
    }
    
    
    func updateMatches(_ d: Double, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["numberOfMatches": FieldValue.increment(1.0)])
    }
    
    func updateScores(_ score:Int64, _ friendId:String) {
        db.collection("User").document(friendId).updateData(["averageScores": FieldValue.increment(score)])
    }
     
    
}
