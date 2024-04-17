//Created by Halbus Development

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

final class BuracoMatchesRepository {
    private var db: Firestore
    private let MatchCollection = Firestore.firestore().collection("scoresModel")
    
    init() {
        db = Firestore.firestore()
    }
    
    func get(completion: @escaping (Result<[MatchFB]?, Error>) -> Void) {
        if let friendID = Auth.auth().currentUser?.uid {
            db.collection(Constants.matches)
                .order(by: "createdTime",  descending: true)
                .whereField("friendsId", arrayContains: friendID)
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot, error == nil else {
                        completion(.failure(error ?? NSError(domain: "Fatch for items failed", code: 103, userInfo: nil)))
                        return
                    }
                    
                    let items: [MatchFB]? = snapshot.documents.compactMap { document in
                        var item = try? document.data(as: MatchFB.self)
                        if item != nil {
                            item!.id = document.documentID
                        }
                        
                        return item
                    }
                    completion(.success(items))
                }
        } else {
            print("There is no user")
        }
    }
    
    func add(match: MatchFB, completion: @escaping (Result<MatchFB?, Error>) -> Void) {
        do {
            let ref = try db.collection(Constants.matches).addDocument(from: match)
 
            let refId: String = ref.documentID
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error ?? NSError(domain: "snapshot is nil", code: 102, userInfo: nil)))
                    return
                }
                let item = try? snapshot.data(as: MatchFB.self)
                
                if let item = item {
                    let returnedItem = MatchFB(id: refId, scoreToWin: item.scoreToWin, playerOne: item.playerOne, playerTwo: item.playerTwo, playerThree: item.playerThree, playerFour: item.playerFour, finalScoreOne: item.finalScoreOne, finalScoreTwo: item.finalScoreTwo, friendsId: item.friendsId, myDate: item.myDate, registeredUser: item.registeredUser, docId: refId, gameOver: item.gameOver)
                    completion(.success(returnedItem))
                }   
            }
        } catch let error {
            print(error)
        }
    }
    
    func delete(item: MatchFB, completion: @escaping(Error?) -> Void) {
        
        guard let itemId: String = item.id else {
            completion(NSError(domain: "Item id is null", code:  105, userInfo: nil))
            return
        }
        
        db.collection(Constants.matches).document(itemId).delete { error in
            if error == nil {
                self.deleteTurns(turnId: itemId) { error in
                    if error == nil {
                        completion(nil)
                    }
                }
                completion(error)
            }
            completion(error)
        }
    }
    
    func deleteTurns(turnId: String, completion: @escaping(Error?) -> Void) {
        
        if turnId.isEmpty {
            completion(NSError(domain: "Item id is null", code:  105, userInfo: nil))
            return
        }
        let batch = db.batch()
        let ref = db.collection(Constants.turns).whereField("turnId", isEqualTo: turnId)
        ref.getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print(error?.localizedDescription ?? "No specific error detected...")
                return
            }
            
            snapshot.documents.forEach { item in
                batch.deleteDocument(item.reference)
            }
            return batch.commit()
        }
    }
    
    func MatchDocument(matchId: String) -> DocumentReference {
        MatchCollection.document(matchId)
    }
    
    func update(matchId: String, matchFB: MatchFB, completion: @escaping(Result<Bool, Error>) -> Void) {
        if matchId.isEmpty {
            completion(.failure(NSError(domain: "Invalid item id", code:  104, userInfo: nil)))
            return
        }
        
        let data: [String:Any] = [
            MatchFB.CodingKeys.finalScoreOne.rawValue : matchFB.finalScoreOne,
            MatchFB.CodingKeys.finalScoreTwo.rawValue : matchFB.finalScoreTwo,
            MatchFB.CodingKeys.gameOver.rawValue : matchFB.gameOver,
        ]
        
        MatchDocument(matchId: matchId).updateData(data)
    }
    
}
