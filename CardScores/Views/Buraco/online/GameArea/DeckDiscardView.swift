//Created by Halbus Development

import SwiftUI

struct DiscardAreaView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    var onClick: () -> Void
    var onDiscard: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(
                            width: proxy.size.width * 0.55,
                            height: 80)
                        .onTapGesture {
                            if cardsVM.isBuyingFromDiscards {
                                onClick()
                            } else if cardsVM.shoudDiscard {
                                onDiscard()
                            }
                        }
       
                    ForEach(Array(zip(cardsVM.onlineBuracoModel.deckDiscard.indices, cardsVM.onlineBuracoModel.deckDiscard)), id: \.0) { index, card in
                        ZStack {
                            Image(card.cardCode)
                                .resizable()
                                .frame(width: 35, height: 60)
                                
                        }
                    }
                }
                .position(
                    x: proxy.size.width * 0.47,
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
    DiscardAreaView(
        onClick: {},
        onDiscard: {}
    )
    .environmentObject(CardsViewModel())
}
