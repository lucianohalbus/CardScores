//Created by Halbus Development

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class BuracoSettings: ObservableObject {
    private var listenerRegistration: ListenerRegistration?
    @Published var showInvitingAlert: Bool = false
    @Published var buracoOnlineID: String = ""
    
    init() {
        self.startListening()
    }
    
//    deinit {
//        listenerRegistration?.remove()
//    }
    
    func startListening() {
        if let playerID = Auth.auth().currentUser?.uid {
            let docRef = Firestore.firestore().collection(Constants.onlinePlayers).document(playerID)
            listenerRegistration = docRef.addSnapshotListener { [weak self] (documentSnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error listening for document updates: \(error)")
                    return
                }
                guard let documentSnapshot = documentSnapshot,
                      let data = documentSnapshot.data() else {
                    print("Document snapshot was nil or contained no data")
                    return
                }
                
                if let gameID = data["gameID"] as? String {
                    DispatchQueue.main.async {
                        self.buracoOnlineID = gameID
                    }
                }
                
                if let returnedItem = data["isInvitedToPlay"] as? Bool {
                    if returnedItem {
                        DispatchQueue.main.async {
                            self.showInvitingAlert = true
                        }
                    }
                }
            }
        }
    }
    
}
