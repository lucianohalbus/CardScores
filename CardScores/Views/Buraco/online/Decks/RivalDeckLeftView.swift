//Created by Halbus Development

import SwiftUI

struct RivalDeckLeftView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @Binding var onlinePlayerModel: OnlinePlayerModel
    var onSelect: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(onlinePlayerModel.deckPlayer) { card in
                            HStack {
                                Button(action: {
                                    if cardsVM.isPlayerTwoDiscarding {
                                        cardsVM.auxDiscardDeck = CardModel(
                                            id: card.id,
                                            cardCode: card.cardCode,
                                            value: card.value,
                                            backColor: card.backColor
                                        )
                                        
                                        cardsVM.onlineBuracoModel.deckDiscard.append(cardsVM.auxDiscardDeck)
                                        
                                        cardsVM.onlineBuracoModel.playerOne.deckPlayer.removeAll { $0 == cardsVM.auxDiscardDeck }
      
                                        Task {
                                            await cardsVM.onlineBuracoRepo.updateOnlineBuracoDecks(onlineBuraco: cardsVM.onlineBuracoModel)
                                        }
                                        
                                        cardsVM.auxDiscardDeck = CardModel(
                                            id: "",
                                            cardCode: "",
                                            value: 0,
                                            backColor: ""
                                        )
                                    }
                                }, label: {
                                    ZStack {
                                        Image(card.backColor)
                                            .resizable()
                                            .frame(width: 30, height: 50)
                                    }
                                })
                            }
                        }
                    }

                    Text(onlinePlayerModel.playerName)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .position(
                            x: proxy.size.width * 0.5,
                            y: proxy.size.height * 0.49
                        )

                }
                .position(
                    x: proxy.size.width * 0.4,
                    y: proxy.size.height * 0.73
                )
                .rotationEffect(.degrees(90))
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(proxy.safeAreaInsets)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    RivalDeckLeftView(
        onlinePlayerModel: .constant(OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer:
                [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"), CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")
                ],
            playerTurn: "",
            onlineScore: 0,
            isInvitedToPlay: false,
            readyToPlay: false
        )),
        onSelect: {}
    )
    .environmentObject(CardsViewModel())
}
