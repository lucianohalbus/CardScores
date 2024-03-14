//Created by Halbus Development

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

final class FirebaseRepository {
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
//    func add(item: MatchFB, completion: @escaping(Result<Item?, Error>) -> Void) {
//        do {
//            let ref = try db.collection(Constants.pantry)
//            .addDocument(from: item)
//
//            ref.getDocument { snapshot, error in
//                guard let snapshot = snapshot, error == nil else {
//                    completion(.failure(error ?? NSError(domain: "snapshot is nil", code: 102, userInfo: nil)))
//                    return
//                }
//
//                let item = try? snapshot.data(as: Item.self)
//                completion(.success(item))
//            }
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//
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
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
        }
    }
    
//    func update(item: Item, completion: @escaping(Result<Bool, Error>) -> Void) {
//        guard let itemId = item.id else {
//            completion(.failure(NSError(domain: "Invalid item id", code:  104, userInfo: nil)))
//            return
//        }
//
//        do {
//            try db.collection(Constants.pantry)
//            .document(itemId)
//            .setData(from: item)
//            completion(.success(true))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//
    func delete(match: MatchFB, completion: @escaping(Error?) -> Void) {

        guard let matchId: String = match.id else {
            completion(NSError(domain: "Match id is null", code:  105, userInfo: nil))
            return
        }

        db.collection(Constants.matches).document(matchId).delete { error in
            if error == nil {
                completion(nil)
            }
            completion(error)
        }
    }
    
}
