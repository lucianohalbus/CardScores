//Created by Halbus Development

import SwiftUI

struct RivalDeckRightView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @Binding var onlinePlayerModel: OnlinePlayerModel
    @State var deck: [CardModel] = []
    var onSelect: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack(spacing: 0) {
                    ForEach(deck) { card in
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
                .frame(maxWidth: .infinity, alignment: .center)
                .rotationEffect(.degrees(90))
                .offset(x: proxy.size.height * 0.25, y: proxy.size.width * 0.9)
            }
            .onAppear {
                self.deck = onlinePlayerModel.deckPlayer
            }
        }
    }
}

#Preview {
    RivalDeckRightView(
        onlinePlayerModel: .constant(OnlinePlayerModel(
            id: "",
            gameID: "",
            playerName: "",
            playerID: "",
            playerEmail: "",
            deckPlayer:
                [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"), CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")
                ],
            playerTurn: ""
        )),
        onSelect: {}
    )
    .environmentObject(CardsViewModel())
}
