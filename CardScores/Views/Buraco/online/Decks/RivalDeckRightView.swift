//Created by Halbus Development

import SwiftUI

struct RivalDeckRightView: View {
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
                                    onSelect()
                                    if !cardsVM.isPlayerFourTurn {
                                        if cardsVM.auxDeck.contains(card) {
                                            cardsVM.auxDeck.removeAll { cards in
                                                cards == card
                                            }
                                        } else {
                                            cardsVM.auxDeck.append(card)
                                        }
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
                        .rotationEffect(.degrees(180))

                }
                .position(
                    x: proxy.size.width * 0.4,
                    y: proxy.size.height * 0.27
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
    RivalDeckRightView(
        onlinePlayerModel: .constant(OnlinePlayerModel(
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer:
                [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"), CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")
                ],
            playerTurn: "",
            isInvitedToPlay: false,
            readyToPlay: false
        )),
        onSelect: {}
    )
    .environmentObject(CardsViewModel())
}
