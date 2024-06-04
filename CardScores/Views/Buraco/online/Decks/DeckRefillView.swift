//Created by Halbus Development

import SwiftUI

struct DeckRefillView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @Binding var deck: [CardModel]
    var refillButtonClicked: () -> Void
    var isPlayerAvailable: Bool {
        if cardsVM.onlineBuracoModel.isPlayerOneTurn {
            return true
        } else if cardsVM.onlineBuracoModel.isPlayerTwoTurn {
            return true
        } else if cardsVM.onlineBuracoModel.isPlayerThreeTurn {
            return true
        } else if cardsVM.onlineBuracoModel.isPlayerFourTurn {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack {
                    ForEach(deck) { card in
                        HStack {
                            Button(action: {
                                if isPlayerAvailable {
                                    if deck.count < 1 {
                                        if cardsVM.isSecondDeckOneAvailable {
                                            deck.append(contentsOf: cardsVM.onlineBuracoModel.playerOne.deckPlayer)
                                            cardsVM.onlineBuracoModel.playerOne.deckPlayer.removeAll()
                                            cardsVM.isSecondDeckOneAvailable = false
                                        } else if cardsVM.isSecondDeckTwoAvailable {
                                            deck.append(contentsOf: cardsVM.onlineBuracoModel.playerTwo.deckPlayer)
                                            cardsVM.onlineBuracoModel.playerTwo.deckPlayer.removeAll()
                                            cardsVM.isSecondDeckTwoAvailable = false
                                       } else {
                                           print("gameOver!!")
                                       }
                                    }
                                    
                                    let cardModel: CardModel = CardModel(
                                        id: card.id,
                                        cardCode: card.cardCode,
                                        value: card.value,
                                        backColor: card.backColor
                                    )
                                    
                                    cardsVM.deleteCardFromDeckRefill(card: cardModel, documentID: cardsVM.onlineBuracoModel.id)
                                    
                                    var deckPlayer: [CardModel] = []
                                    deckPlayer.append(contentsOf: cardsVM.onlineBuracoModel.playerOne.deckPlayer)
                                    deckPlayer.append(card)
                                    
                                    let playerOne: OnlinePlayerModel = OnlinePlayerModel(
                                        playerName: cardsVM.onlineBuracoModel.playerOne.playerName,
                                        playerID: cardsVM.onlineBuracoModel.playerOne.playerID,
                                        playerEmail: cardsVM.onlineBuracoModel.playerOne.playerEmail,
                                        deckPlayer: deckPlayer,
                                        playerTurn: cardsVM.onlineBuracoModel.playerOne.playerTurn,
                                        onlineScore: 0
                                    )

                                    cardsVM.updatePlayerDeck(playerOne: playerOne, documentID: cardsVM.onlineBuracoModel.id)
                                    
                                    let isTurnOneNext: Bool = false
                                    let isTurnTwoNext: Bool = true
                                    let isTurnThreeNext: Bool = false
                                    let isTurnFourNext: Bool = false

                                    cardsVM.updateNextTurns(turnOne: isTurnOneNext, turnTwo: isTurnTwoNext, turnThree: isTurnThreeNext, turnFour: isTurnFourNext)
                                    
                                    refillButtonClicked()
                                }
                            }, label: {
                                ZStack {
                                    Image(card.backColor)
                                        .resizable()
                                        .frame(width: 35, height: 60)
                                    
                                    Text(deck.count.description)
                                        .font(.title3)
                                        .foregroundStyle(Color.white)
                                }
                            })
                        }
                    }
                }
                .position(
                    x: proxy.size.width * 0.12,
                    y: proxy.size.height * 0.45
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(proxy.safeAreaInsets)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DeckRefillView(deck: .constant(
        [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"), CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    ), 
        refillButtonClicked: {}
    )
    .environmentObject(CardsViewModel())
}
