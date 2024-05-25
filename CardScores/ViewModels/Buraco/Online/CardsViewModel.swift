//Created by Halbus Development

import Foundation

final class CardsViewModel: ObservableObject {
    @Published var onlineBuracoRepo: OnlineBuracoRepository
    @Published var playerOne: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerTwo: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerThree: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var playerFour: FriendsModel = FriendsModel(friendId: "", friendEmail: "", friendName: "")
    @Published var createPlayers: Bool = false
    @Published var showOnlineGame: Bool = false
    
    // MARK: - DECKS
    @Published var secondDeckOne: [CardModel] = []
    @Published var secondDeckTwo: [CardModel] = []
    @Published var deckRefill: [CardModel] = []
    @Published var auxDeck: [CardModel] = []
    @Published var discardDeck: [CardModel] = []
    
    // MARK: - TURN LOGICS
    @Published var isSecondDeckOneAvailable: Bool = true
    @Published var isSecondDeckTwoAvailable: Bool = true
    @Published var isPlayerOneTurn: Bool = true
    @Published var isPlayerTwoTurn: Bool = false
    @Published var isPlayerThreeTurn: Bool = false
    @Published var isPlayerFourTurn: Bool = false
    @Published var deckPlayerUpdated: Bool = false
    @Published var deckRefillUpdated: Bool = false
    @Published var deckDiscardUpdated: Bool = false
    
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
        deckPlayerOne: [],
        deckPlayerTwo: [],
        deckPlayerThree: [],
        deckPlayerFour: [],
        deckDiscard: [],
        deckSecondOne: [],
        deckSecondTwo: [],
        deckRefill: [],
        playerTurn: ""
    )
    
    @Published var onlinePlayerOne: OnlinePlayerModel = OnlinePlayerModel(
        gameID: "",
        playerName: "",
        playerID: "",
        playerEmail: "",
        deckPlayer: [CardModel(id: "", cardCode: "", value: 0, backColor: "")],
        playerTurn: ""
    )
    
    @Published var onlinePlayerTwo: OnlinePlayerModel = OnlinePlayerModel(
        gameID: "",
        playerName: "",
        playerID: "",
        playerEmail: "",
        deckPlayer: [CardModel(id: "", cardCode: "", value: 0, backColor: "")],
        playerTurn: ""
    )
    
    @Published var onlinePlayerThree: OnlinePlayerModel = OnlinePlayerModel(
        gameID: "",
        playerName: "",
        playerID: "",
        playerEmail: "",
        deckPlayer: [CardModel(id: "", cardCode: "", value: 0, backColor: "")],
        playerTurn: ""
    )
    
    @Published var onlinePlayerFour: OnlinePlayerModel = OnlinePlayerModel(
        gameID: "",
        playerName: "",
        playerID: "",
        playerEmail: "",
        deckPlayer: [CardModel(id: "", cardCode: "", value: 0, backColor: "")],
        playerTurn: ""
    )

   

    init() {
        onlineBuracoRepo = OnlineBuracoRepository()
    }

    func preparingDecks() {
        secondDeckOne.removeAll()
        secondDeckTwo.removeAll()
        deckRefill.removeAll()
        discardDeck.removeAll()
        onlinePlayerOne.deckPlayer.removeAll()
        onlinePlayerTwo.deckPlayer.removeAll()
        onlinePlayerThree.deckPlayer.removeAll()
        onlinePlayerFour.deckPlayer.removeAll()
        
        var allCard: [CardModel] = []
        var sortedCards: [CardModel] = []
        
        allCard.append(contentsOf: cardsOne)
        allCard.append(contentsOf: cardsTwo)
        
        sortedCards = allCard.shuffled()
        
        for index in 0..<sortedCards.count {
            switch index {
            case 0...10:
                onlineBuracoModel.deckPlayerOne.append(sortedCards[index])
            case 11...21:
                onlineBuracoModel.deckPlayerTwo.append(sortedCards[index])
            case 22...32:
                onlineBuracoModel.deckPlayerThree.append(sortedCards[index])
            case 33...43:
                onlineBuracoModel.deckPlayerFour.append(sortedCards[index])
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
        
        self.preparingGameTable(onlineGame: onlineBuracoModel)
    }
    
    func preparingGameTable(onlineGame: OnlineBuracoModel) {
        onlineBuracoRepo.add(onlineBuraco: onlineBuracoModel) { result in
            switch result {
            case .success(let onlineBuraco):
                if let returnedOnlineBuraco = onlineBuraco {
                    self.onlinePlayerOne = OnlinePlayerModel(
                        gameID: returnedOnlineBuraco.id,
                        playerName: self.playerOne.friendName,
                        playerID: self.playerOne.friendId,
                        playerEmail: self.playerOne.friendEmail,
                        deckPlayer: returnedOnlineBuraco.deckPlayerOne,
                        playerTurn: self.playerOne.friendId
                    )
                    
                    self.onlinePlayerTwo = OnlinePlayerModel(
                        gameID: returnedOnlineBuraco.id,
                        playerName: self.playerTwo.friendName,
                        playerID: self.playerTwo.friendId,
                        playerEmail: self.playerOne.friendEmail,
                        deckPlayer: returnedOnlineBuraco.deckPlayerTwo,
                        playerTurn: self.playerTwo.friendId
                    )
                    
                    self.onlinePlayerThree = OnlinePlayerModel(
                        gameID: returnedOnlineBuraco.id,
                        playerName: self.playerThree.friendName,
                        playerID: self.playerThree.friendId,
                        playerEmail: self.playerThree.friendEmail,
                        deckPlayer: returnedOnlineBuraco.deckPlayerThree,
                        playerTurn: self.playerThree.friendId
                    )
                    
                    self.onlinePlayerFour = OnlinePlayerModel(
                        gameID: returnedOnlineBuraco.id,
                        playerName: self.playerFour.friendName,
                        playerID: self.playerFour.friendId,
                        playerEmail: self.playerFour.friendEmail,
                        deckPlayer: returnedOnlineBuraco.deckPlayerFour,
                        playerTurn: self.playerFour.friendId
                    )
                    
                    self.deckRefill = returnedOnlineBuraco.deckRefill
                    
                    self.createPlayers = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addOnlinePlayers() async throws {
        try await onlineBuracoRepo.addPlayer(onlinePlayer: onlinePlayerOne)
        try await onlineBuracoRepo.addPlayer(onlinePlayer: onlinePlayerTwo)
        try await onlineBuracoRepo.addPlayer(onlinePlayer: onlinePlayerThree)
        try await onlineBuracoRepo.addPlayer(onlinePlayer: onlinePlayerFour)
        
        self.showOnlineGame = true
    }
    
    func updatePlayerDeck(deckPlayer: [CardModel], onlinePlayer: OnlinePlayerModel) {
        onlineBuracoRepo.updatePlayerDeck(deckPlayer: deckPlayer, onlinePlayer: onlinePlayer) { result in
            switch result {
            case .success(let returnedItem):
                self.deckPlayerUpdated = returnedItem
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteCardFromDeckRefill(card: CardModel) {
        onlineBuracoRepo.deleteCardFromDeckRefill(deckRefill: card, onlineBuracoID: onlinePlayerOne.gameID) { result in
            switch result {
            case .success(let returnedItem):
                self.deckRefillUpdated = returnedItem
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateDeckDiscard(deckDiscard: [CardModel]) {
        onlineBuracoRepo.updateDeckDiscard(deckDiscard: deckDiscard, onlineBuracoID: onlinePlayerOne.gameID) { result in
            switch result {
            case .success(let returnedItem):
                self.deckDiscardUpdated = returnedItem
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
