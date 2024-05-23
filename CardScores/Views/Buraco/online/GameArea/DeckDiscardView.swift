//Created by Halbus Development

import SwiftUI

struct DiscardAreaView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    var onClick: () -> Void
    var onDiscard: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color.green)
                    .frame(width: 200, height: 60)
                    .offset(x: 100)
                    .onTapGesture {
                        if cardsVM.isBuyingFromDiscards {
                            onClick()
                        } else if cardsVM.shoudDiscard {
                            onDiscard()
                        }
                    }
   
                ForEach(Array(zip(cardsVM.discardDeck.indices, cardsVM.discardDeck)), id: \.0) { index, card in
                    ZStack {
                        Image(card.cardCode)
                            .resizable()
                            .frame(width: 35, height: 60)
                            .offset(x: CGFloat(index*10))
                    }
                }
            }
            .frame(width: proxy.size.height * 0.4, alignment: .center)
            .offset(x: -50, y: proxy.size.height * 0.45)
        }
    }
}

#Preview {
    DiscardAreaView(
        onClick: {},
        onDiscard: {}
    )
    .environmentObject(CardsViewModel())
}
