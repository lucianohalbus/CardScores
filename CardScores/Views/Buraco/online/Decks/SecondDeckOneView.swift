//Created by Halbus Development

import SwiftUI

struct SecondDeckOneView: View {
    @Binding var deck: [CardModel]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack {
                    ForEach(deck) { card in
                        HStack {
                            Button(action: {
                               
                            }, label: {
                                ZStack {
                                    Image(card.backColor)
                                        .resizable()
                                        .frame(width: 35, height: 60)
                                }
                            })
                        }
                    }
                }
                .position(
                    x: proxy.size.width * 0.85,
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
    SecondDeckOneView(deck: .constant(
        [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2"), CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    ))
}
