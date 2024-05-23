//Created by Halbus Development

import SwiftUI

struct gameAreaTwoView: View {
    @State var deckOne: [CardModel] = [CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"),CardModel(id: "clubsQ", cardCode: "card11", value: 10, backColor: "cardBack1"), CardModel(id: "spadesFour", cardCode: "card42", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2"), CardModel(id: "DiamondsThree", cardCode: "card15", value: 5, backColor: "cardBack2")]
    @State var deckTwo: [CardModel] = [CardModel(id: "clubsTen", cardCode: "card9", value: 10, backColor: "cardBack1"), CardModel(id: "DiamondsFour", cardCode: "card16", value: 5, backColor: "cardBack2")]
    @State var deckThree: [CardModel] = [CardModel(id: "clubsNine", cardCode: "card8", value: 10, backColor: "cardBack1"), CardModel(id: "clubsSix", cardCode: "card5", value: 5, backColor: "cardBack1"), CardModel(id: "spadesSix", cardCode: "card44", value: 5, backColor: "cardBack2")]
    @State var deckFour: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    @State var deckFive: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    @State var deckSix: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    @State var deckFSeven: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    @State var deckEight: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    @State var deckNive: [CardModel] = [CardModel(id: "DiamondsK", cardCode: "card25", value: 10, backColor: "cardBack1"), CardModel(id: "clubsJ", cardCode: "card10", value: 10, backColor: "cardBack2"), CardModel(id: "clubsEight", cardCode: "card7", value: 10, backColor: "cardBack2")]
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 100, height: 200)
                .foregroundColor(Color.clear)
            
            VStack {
                Rectangle()
                    .frame(width: 100, height: 300)
                    .foregroundColor(Color.clear)
                
                
                ZStack {
                    HStack {
                        ZStack {
                            ForEach(Array(zip(deckOne.indices, deckOne)), id: \.0) { index, card in
                                ZStack {
                                    Image(card.cardCode)
                                        .resizable()
                                        .frame(width: 40, height: 60)
                                        .stacked(at: index, in: deckOne.count)
                                }
                            }
                        }
                    }
                }
                
                ZStack {
                    HStack {
                        ZStack {
                            ForEach(Array(zip(deckOne.indices, deckOne)), id: \.0) { index, card in
                                ZStack {
                                    Image(card.cardCode)
                                        .resizable()
                                        .frame(width: 40, height: 60)
                                        .stacked(at: index, in: deckOne.count)
                                }
                            }
                        }
                    }
                }
                
                ZStack {
                    HStack {
                        ZStack {
                            ForEach(Array(zip(deckOne.indices, deckOne)), id: \.0) { index, card in
                                ZStack {
                                    Image(card.cardCode)
                                        .resizable()
                                        .frame(width: 40, height: 60)
                                        .stacked(at: index, in: deckOne.count)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    gameAreaTwoView()
}
