//Created by Halbus Development

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class BuracoSettings: ObservableObject {
    private var listenerRegistration: ListenerRegistration?
    @Published var showInvitingAlert: Bool = false
    @Published var gameID: String = ""
    @Published var isOnlineBuracoUpdated: Bool = false
    @Published var onlineBuracoModel: OnlineBuracoModel = OnlineBuracoModel(id: "", deckDiscard: [], deckSecondOne: [], deckSecondTwo: [], deckRefill: [], playerOne: OnlinePlayerModel(playerName: "", playerID: "", playerEmail: "", deckPlayer: [], playerTurn: ""), playerTwo: OnlinePlayerModel(playerName: "", playerID: "", playerEmail: "", deckPlayer: [], playerTurn: ""), playerThree: OnlinePlayerModel(playerName: "", playerID: "", playerEmail: "", deckPlayer: [], playerTurn: ""), playerFour: OnlinePlayerModel(playerName: "", playerID: "", playerEmail: "", deckPlayer: [], playerTurn: ""), playerTurn: "", isPlayerOneInvited: false, isPlayerTwoInvited: false, isPlayerThreeInvited: false, isPlayerFourInvited: false, playersID: [])
    
    init() {
        startListening()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func onlineDocument(onlineID: String, path: String) -> DocumentReference {
        Firestore.firestore().collection(path).document(onlineID)
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
    
    func updatePlayerInvite() async throws {
        guard let playerID = Auth.auth().currentUser?.uid else {
            return
        }

        let data: [String:Any] = [
            InviteModel.CodingKeys.isInviting.rawValue : false
        ]
        
        try await onlineDocument(
            onlineID: playerID,
            path: Constants.invitedPlayers
        ).updateData(data)
    }
    
}
