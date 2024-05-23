//Created by Halbus Development

import SwiftUI

struct MainDeckView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @Binding var onlinePlayerModel: OnlinePlayerModel

    var onSelect: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack(spacing: 0) {
                    ForEach(onlinePlayerModel.deckPlayer) { card in
                        HStack {
                            Button(action: {
                                onSelect()
                                if cardsVM.isPlayerOneDiscarding {
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
                                    Image(card.cardCode)
                                        .resizable()
                                        .frame(width: 35, height: 60)
                                }
                            })
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .offset(y: proxy.size.height * 0.9)
                
            }
        }
    }
}

#Preview {
    MainDeckView(
        onlinePlayerModel: .constant(OnlinePlayerModel(
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
