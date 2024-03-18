//Created by Halbus Development

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class BuracoTurnsRepository: ObservableObject {
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func getTurns(completion: @escaping (Result<[MatchTurn]?, Error>) -> Void) {
        if let friendID = Auth.auth().currentUser?.uid {
            db.collection(Constants.turns)
                .order(by: "createdTime",  descending: true)
                .whereField("friendsId", arrayContains: friendID)
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot, error == nil else {
                        completion(.failure(error ?? NSError(domain: "Fatch for items failed", code: 103, userInfo: nil)))
                        return
                    }
                    
                    let items: [MatchTurn]? = snapshot.documents.compactMap { document in
                        var item = try? document.data(as: MatchTurn.self)
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
    
    func addTurn(matchTurn: MatchTurn, completion: @escaping (Result<MatchTurn?, Error>) -> Void) {
        do {
            let ref = try db.collection(Constants.turns).addDocument(from: matchTurn)
            
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error ?? NSError(domain: "snapshot is nil", code: 102, userInfo: nil)))
                    return
                }
                
                let item = try? snapshot.data(as: MatchTurn.self)
                completion(.success(item))
            }
        } catch let error {
            print(error)
        }
    }

}
