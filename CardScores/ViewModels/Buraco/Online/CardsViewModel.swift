//Created by Halbus Development

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CardsViewModel: ObservableObject {
    @Published var onlineBuracoRepo: OnlineBuracoRepository
    @Published var playerOne: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerTwo: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerThree: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerFour: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var createPlayers: Bool = false
    @Published var showOnlineGame: Bool = false
    
    // MARK: - DECKS
    @Published var auxDeck: [CardModel] = []
    
    // MARK: - TURN LOGICS
    @Published var cardDeletedFromDeckRefill: Bool = false
    
    
    
    @Published var isSecondDeckOneAvailable: Bool = true
    @Published var isSecondDeckTwoAvailable: Bool = true
    @Published var deckPlayerUpdated: Bool = false
    @Published var deckRefillUpdated: Bool = false
    @Published var deckDiscardUpdated: Bool = false
    @Published var isGameStarted: Bool = false
    @Published var allPlayersReady: Bool = false
    @Published var shouldInvitePlayers: Bool = false
    @Published var isReceivingInvite: Bool = false
    @Published var addPlayers: Bool = false
    @Published var playersAdded: Bool = false
    @Published var isPlayerInvited: Bool = false
    
    // MARK: - CARD / DISCARD LOGICS
    @Published var isBuyingFromDeckRefill: Bool = true
    @Published var isBuyingFromDiscards: Bool = false
    @Published var shoudDiscard: Bool = false
    @Published var isPlayerOneDiscarding: Bool = true
    @Published var isPlayerTwoDiscarding: Bool = false
    @Published var isPlayerThreeDiscarding: Bool = false
    @Published var isPlayerFourDiscarding: Bool = false

    
    // MARK: - ONLINE DOCUMENTS
    @Published var onlineBuracoModel: OnlineBuracoModel = OnlineBuracoModel(
        id: "",
        deckDiscard: [],
        deckSecondOne: [],
        deckSecondTwo: [],
        deckRefill: [],
        playerOne: OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer: [],
            playerTurn: "",
            onlineScore: 0,
            isInvitedToPlay: false,
            readyToPlay: false
        ),
        playerTwo: OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer: [],
            playerTurn: "",
            onlineScore: 0,
            isInvitedToPlay: false,
            readyToPlay: false
        ),
        playerThree: OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer: [],
            playerTurn: "",
            onlineScore: 0,
            isInvitedToPlay: false,
            readyToPlay: false
        ),
        playerFour: OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer: [],
            playerTurn: "",
            onlineScore: 0,
            isInvitedToPlay: false,
            readyToPlay: false
        ),
        playerTurn: "",
        isPlayerOneTurn: false,
        isPlayerTwoTurn: false,
        isPlayerThreeTurn: false,
        isPlayerFourTurn: false,
        playersID: []
    )
    
    @Published var auxDiscardDeck: CardModel = CardModel(
        id: "",
        cardCode: "",
        value: 0,
        backColor: ""   
    )
    
    @Published var listeningOnlineBuraco: [OnlineBuracoModel] = []
   
    init() {
        self.onlineBuracoRepo = OnlineBuracoRepository()  
        listenToOnlineBuraco()
    }
    
    func listenToOnlineBuraco() {
        Firestore.firestore().collection(Constants.onlineBuraco)
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("Nenhum documento encontrado")
                        return
                    }
                    
                    self.listeningOnlineBuraco = documents.compactMap { queryDocumentSnapshot -> OnlineBuracoModel? in
                        try? queryDocumentSnapshot.data(as: OnlineBuracoModel.self)
                    }
                    
                    for document in self.listeningOnlineBuraco {
                        if document.id == self.onlineBuracoModel.id {
                            self.onlineBuracoModel = document
                        }
                    }
                }
        }
    
    func listenInvitation(onlineBuracoID: String) {
     //   BuracoSettings.share.startListening()
    }
    
    func addInitialOnlineBuraco() {
        let initialBuraco: OnlineBuracoModel = OnlineBuracoModel(
            id: "",
            deckDiscard: [],
            deckSecondOne: [],
            deckSecondTwo: [],
            deckRefill: [],
            playerOne: OnlinePlayerModel(
                playerName: "",
                playerID: "",
                playerEmail: "",
                deckPlayer: [],
                playerTurn: "",
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerTwo: OnlinePlayerModel(
                playerName: "",
                playerID: "",
                playerEmail: "",
                deckPlayer: [],
                playerTurn: "",
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerThree: OnlinePlayerModel(
                playerName: "",
                playerID: "",
                playerEmail: "",
                deckPlayer: [],
                playerTurn: "",
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerFour: OnlinePlayerModel(
                playerName: "",
                playerID: "",
                playerEmail: "",
                deckPlayer: [],
                playerTurn: "",
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerTurn: "",
            isPlayerOneTurn: false,
            isPlayerTwoTurn: false,
            isPlayerThreeTurn: false,
            isPlayerFourTurn: false,
            playersID: []
        )
        
        onlineBuracoRepo.addInitialOnlineBuraco(onlineBuraco: initialBuraco) { result in
            switch result {
            case .success(let returnedItem):
                if let returnedID = returnedItem { 
                    self.preparingDecks(gameID: returnedID)
                 //   self.listenInvitation(onlineBuracoID: returnedID)
                }
            case .failure(let error):
                print("addInitialOnlineBuraco error. Error => \(error.localizedDescription)")
            }
        }
    }
    
    func preparingDecks(gameID: String) {
        var allCard: [CardModel] = []
        var sortedCards: [CardModel] = []
        
        allCard.append(contentsOf: cardsOne)
        allCard.append(contentsOf: cardsTwo)
        
        sortedCards = allCard.shuffled()
        
        for index in 0..<sortedCards.count {
            switch index {
            case 0...10:
                onlineBuracoModel.playerOne.deckPlayer.append(sortedCards[index])
            case 11...21:
                onlineBuracoModel.playerTwo.deckPlayer.append(sortedCards[index])
            case 22...32:
                onlineBuracoModel.playerThree.deckPlayer.append(sortedCards[index])
            case 33...43:
                onlineBuracoModel.playerFour.deckPlayer.append(sortedCards[index])
            case 44...54:
                onlineBuracoModel.deckSecondOne.append(sortedCards[index])
            case 55...65:
                onlineBuracoModel.deckSecondTwo.append(sortedCards[index])
            case 66...103:
                onlineBuracoModel.deckRefill.append(sortedCards[index])
            default:
                break
            }
        }
        
        let onlineBuraco: OnlineBuracoModel = OnlineBuracoModel(
            id: gameID,
            deckDiscard: onlineBuracoModel.deckDiscard,
            deckSecondOne: onlineBuracoModel.deckSecondOne,
            deckSecondTwo: onlineBuracoModel.deckSecondTwo,
            deckRefill: onlineBuracoModel.deckRefill,
            playerOne: OnlinePlayerModel(
                playerName: playerOne.friendName,
                playerID: playerOne.friendId,
                playerEmail: playerOne.friendEmail,
                deckPlayer: onlineBuracoModel.playerOne.deckPlayer,
                playerTurn: playerOne.friendId,
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerTwo: OnlinePlayerModel(
                playerName: playerTwo.friendName,
                playerID: playerTwo.friendId,
                playerEmail: playerTwo.friendEmail,
                deckPlayer: onlineBuracoModel.playerTwo.deckPlayer,
                playerTurn: playerTwo.friendId,
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerThree: OnlinePlayerModel(
                playerName: playerThree.friendName,
                playerID: playerThree.friendId,
                playerEmail: playerThree.friendEmail,
                deckPlayer: onlineBuracoModel.playerThree.deckPlayer,
                playerTurn: playerThree.friendId,
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerFour: OnlinePlayerModel(
                playerName: playerFour.friendName,
                playerID: playerFour.friendId,
                playerEmail: playerFour.friendEmail,
                deckPlayer: onlineBuracoModel.playerFour.deckPlayer,
                playerTurn: playerFour.friendId,
                onlineScore: 0,
                isInvitedToPlay: false,
                readyToPlay: false
            ),
            playerTurn: playerOne.friendId,
            isPlayerOneTurn: true,
            isPlayerTwoTurn: false,
            isPlayerThreeTurn: false,
            isPlayerFourTurn: false,
            playersID: [playerOne.friendId, playerTwo.friendId, playerThree.friendId, playerFour.friendId]
        )

        onlineBuracoRepo.updateOnlineBuraco(onlineBuraco: onlineBuraco) { result in
            switch result {
            case .success(let returnedItem):
                if let returnedBool = returnedItem {
                   if returnedBool {
                       self.addInviteOnlinePlayers(gameID: onlineBuraco.id)
                    }
                }
            case .failure(let error):
                print("Error in updateInitialOnlineBuraco: \(error)")
            }
        }
    }
    
    func addInviteOnlinePlayers(gameID: String) {
        var invitedPlayers: [InviteModel] = []
        
        let invitedPlayerOne: InviteModel = InviteModel(
            playerID: playerOne.friendId,
            gameID: gameID,
            isInviting: true
        )
        invitedPlayers.append(invitedPlayerOne)
        
        let invitedPlayerTwo: InviteModel = InviteModel(
            playerID: playerTwo.friendId,
            gameID: gameID,
            isInviting: true
        )
        invitedPlayers.append(invitedPlayerTwo)
        
        let invitedPlayerThree: InviteModel = InviteModel(
            playerID: playerThree.friendId,
            gameID: gameID,
            isInviting: true
        )
        invitedPlayers.append(invitedPlayerThree)
        
        let invitedPlayerFour: InviteModel = InviteModel(
            playerID: playerFour.friendId,
            gameID: gameID,
            isInviting: true
        )
        invitedPlayers.append(invitedPlayerFour)

        onlineBuracoRepo.invitePlayer(invitedPlayer: invitedPlayers)
    }
    
    @MainActor
    func getOnlineBuraco(onlineBuracoID: String) async throws {
        let onlineBuraco = await onlineBuracoRepo.getOnlineBuraco(onlineBuracoID: onlineBuracoID)
        
        self.onlineBuracoModel = onlineBuraco
        self.isPlayerInvited = true
    }
    
    func deleteCardFromDeckRefill(card: CardModel, documentID: String) {
        onlineBuracoRepo.removeCardFromDeck(documentID: documentID, fieldName: "deckRefill", element: card) { result in
            switch result {
            case .success(let returnedItem):
                print("\(returnedItem)chegou aqui no fim do deleteCardFromDeckRefill")
//                DispatchQueue.main.async {
//                    self.cardDeletedFromDeckRefill = returnedItem
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updatePlayerDeck(playerOne: OnlinePlayerModel, documentID: String) {
        onlineBuracoRepo.updatePlayerDeck(onlineBuracoID: documentID, playerOne: playerOne) { result in
            switch result {
            case .success(let returnedItem):
                print("\(returnedItem)chegou aqui no fim do updatePlayerDeck")
//                DispatchQueue.main.async {
//                    self.deckPlayerUpdated = returnedItem
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateDeckDiscard(deckDiscard: CardModel) {
//        onlineBuracoRepo.updateDeckDiscard(deckDiscard: deckDiscard, onlineBuracoID: onlineBuracoModel.id) { result in
//            switch result {
//            case .success(let returnedItem):
//                DispatchQueue.main.async {
//                    self.deckDiscardUpdated = returnedItem
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func deleteCardFromPlayerDeck(playerDeck: CardModel) {
//        onlineBuracoRepo.updateDeckDiscard(deckDiscard: playerDeck, onlineBuracoID: onlineBuracoModel.id) { result in
//            switch result {
//            case .success(let returnedItem):
//                DispatchQueue.main.async {
//                    
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func updateReadyToPlay(readyToPlay: Bool) {
//        onlineBuracoRepo.updateReadyToPlay(readyToPlay: readyToPlay) { result in
//            switch result {
//            case .success(let returnedValue):
//                DispatchQueue.main.async {
//                    self.showOnlineGame = returnedValue
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    @Published var cardsOne: [CardModel] = [
            CardModel(id: "clubsTwo", cardCode: "card1", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsThree", cardCode: "card2", value: 5, backColor: "cardBack1"),
            CardModel(id: "clubsFour", cardCode: "card3", value: 5, backColor: "cardBack1"),
            CardModel(id: "clubsFive", cardCode: "card4", value: 5, backColor: "cardBack1"),
            CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"),
            CardModel(id: "clubsSeven", cardCode: "card6", value: 5, backColor: "cardBack1"),
            CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsK", cardCode: "card12", value: 10, backColor: "cardBack1"),
            CardModel(id: "clubsAs", cardCode: "card13", value: 15, backColor: "cardBack1"),
            CardModel(id: "DiamondsTwo", cardCode: "card14", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack1"),
            CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack1"),
            CardModel(id: "DiamondsFive", cardCode: "card17", value: 5, backColor: "cardBack1"),
            CardModel(id: "DiamondsSix", cardCode: "card18", value: 5, backColor: "cardBack1"),
            CardModel(id: "DiamondsSeven", cardCode: "card19", value: 5, backColor: "cardBack1"),
            CardModel(id: "DiamondsEight", cardCode: "card20", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsNine", cardCode: "card21", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsTen", cardCode: "card22", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsJ", cardCode: "card23", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsQ", cardCode: "card24", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"),
            CardModel(id: "DiamondsAs", cardCode: "card26", value: 15, backColor: "cardBack1"),
            CardModel(id: "heartsTwo", cardCode: "card27", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsThree", cardCode: "card28", value: 5, backColor: "cardBack1"),
            CardModel(id: "heartsFour", cardCode: "card29", value: 5, backColor: "cardBack1"),
            CardModel(id: "heartsFive", cardCode: "card30", value: 5, backColor: "cardBack1"),
            CardModel(id: "heartsSix", cardCode: "card31", value: 5, backColor: "cardBack1"),
            CardModel(id: "heartsSeven", cardCode: "card32", value: 5, backColor: "cardBack1"),
            CardModel(id: "heartsEight", cardCode: "card33", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsNine", cardCode: "card34", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsTen", cardCode: "card35", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsJ", cardCode: "card36", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsQ", cardCode: "card37", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsK", cardCode: "card38", value: 10, backColor: "cardBack1"),
            CardModel(id: "heartsAs", cardCode: "card39", value: 15, backColor: "cardBack1"),
            CardModel(id: "spadesTwo", cardCode: "card40", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesThree", cardCode: "card41", value: 5, backColor: "cardBack1"),
            CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack1"),
            CardModel(id: "spadesFive", cardCode: "card43", value: 5, backColor: "cardBack1"),
            CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack1"),
            CardModel(id: "spadesSeven", cardCode: "card45", value: 5, backColor: "cardBack1"),
            CardModel(id: "spadesEight", cardCode: "card46", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesNine", cardCode: "card47", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesTen", cardCode: "card48", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesJ", cardCode: "card48", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesQ", cardCode: "card50", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesK", cardCode: "card51", value: 10, backColor: "cardBack1"),
            CardModel(id: "spadesAs", cardCode: "card52", value: 15, backColor: "cardBack1")]
    
    @Published var cardsTwo: [CardModel] = [
            CardModel(id: "clubsTwo", cardCode: "card1", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsThree", cardCode: "card2", value: 5, backColor: "cardBack2"),
            CardModel(id: "clubsFour", cardCode: "card3", value: 5, backColor: "cardBack2"),
            CardModel(id: "clubsFive", cardCode: "card4", value: 5, backColor: "cardBack2"),
            CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack2"),
            CardModel(id: "clubsSeven", cardCode: "card6", value: 5, backColor: "cardBack2"),
            CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsK", cardCode: "card12", value: 10, backColor: "cardBack2"),
            CardModel(id: "clubsAs", cardCode: "card13", value: 15, backColor: "cardBack2"),
            CardModel(id: "DiamondsTwo", cardCode: "card14", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"),
            CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"),
            CardModel(id: "DiamondsFive", cardCode: "card17", value: 5, backColor: "cardBack2"),
            CardModel(id: "DiamondsSix", cardCode: "card18", value: 5, backColor: "cardBack2"),
            CardModel(id: "DiamondsSeven", cardCode: "card19", value: 5, backColor: "cardBack2"),
            CardModel(id: "DiamondsEight", cardCode: "card20", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsNine", cardCode: "card21", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsTen", cardCode: "card22", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsJ", cardCode: "card23", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsQ", cardCode: "card24", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack2"),
            CardModel(id: "DiamondsAs", cardCode: "card26", value: 15, backColor: "cardBack2"),
            CardModel(id: "heartsTwo", cardCode: "card27", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsThree", cardCode: "card28", value: 5, backColor: "cardBack2"),
            CardModel(id: "heartsFour", cardCode: "card29", value: 5, backColor: "cardBack2"),
            CardModel(id: "heartsFive", cardCode: "card30", value: 5, backColor: "cardBack2"),
            CardModel(id: "heartsSix", cardCode: "card31", value: 5, backColor: "cardBack2"),
            CardModel(id: "heartsSeven", cardCode: "card32", value: 5, backColor: "cardBack2"),
            CardModel(id: "heartsEight", cardCode: "card33", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsNine", cardCode: "card34", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsTen", cardCode: "card35", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsJ", cardCode: "card36", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsQ", cardCode: "card37", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsK", cardCode: "card38", value: 10, backColor: "cardBack2"),
            CardModel(id: "heartsAs", cardCode: "card39", value: 15, backColor: "cardBack2"),
            CardModel(id: "spadesTwo", cardCode: "card40", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesThree", cardCode: "card41", value: 5, backColor: "cardBack2"),
            CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"),
            CardModel(id: "spadesFive", cardCode: "card43", value: 5, backColor: "cardBack2"),
            CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"),
            CardModel(id: "spadesSeven", cardCode: "card45", value: 5, backColor: "cardBack2"),
            CardModel(id: "spadesEight", cardCode: "card46", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesNine", cardCode: "card47", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesTen", cardCode: "card48", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesJ", cardCode: "card48", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesQ", cardCode: "card50", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesK", cardCode: "card51", value: 10, backColor: "cardBack2"),
            CardModel(id: "spadesAs", cardCode: "card52", value: 15, backColor: "cardBack2")]  
}
