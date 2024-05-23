//Created by Halbus Development

import SwiftUI

struct DeckRefillView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @Binding var deck: [CardModel]
    var refillButtonClicked: () -> Void
    var isPlayerAvailable: Bool {
        if cardsVM.isPlayerOneTurn {
            return true
        } else if cardsVM.isPlayerTwoTurn {
            return true
        } else if cardsVM.isPlayerThreeTurn {
            return true
        } else if cardsVM.isPlayerFourTurn {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(deck) { card in
                    HStack {
                        Button(action: {
                            if isPlayerAvailable {
                                
                                refillButtonClicked()
                                
                                if deck.count < 1 {
                                    if cardsVM.isSecondDeckOneAvailable {
                                        deck.append(contentsOf: cardsVM.secondDeckOne)
                                        cardsVM.secondDeckOne.removeAll()
                                        cardsVM.isSecondDeckOneAvailable = false
                                    } else if cardsVM.isSecondDeckTwoAvailable {
                                       deck.append(contentsOf: cardsVM.secondDeckTwo)
                                        cardsVM.secondDeckTwo.removeAll()
                                        cardsVM.isSecondDeckTwoAvailable = false
                                   } else {
                                       print("gameOver!!")
                                   }
                                }
                                
                                deck.removeLast()
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
            .frame(maxWidth: .infinity, alignment: .center)
            .offset(x: -145, y: proxy.size.height * 0.45)
        }
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
