//Created by Halbus Development

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class BuracoSettings: ObservableObject {
    private var listenerRegistration: ListenerRegistration?
    @Published var showInvitingAlert: Bool = false
    @Published var gameID: String = ""
    
    init() {
        startListening()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func startListening() {
        
        self.showInvitingAlert = false
        self.gameID = ""
        
        if let playerID = Auth.auth().currentUser?.uid {
            let docRef = Firestore.firestore().collection(Constants.invitedPlayers).document(playerID)
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
                
                guard let returnedID = data["gameID"] as? String else { return }

                if let returnedItem = data["isInviting"] as? Bool {
                    if returnedItem {
                        DispatchQueue.main.async {
                            self.showInvitingAlert = returnedItem
                            self.gameID = returnedID
                        }
                    }
                }
            }
        }
    }
  
}
