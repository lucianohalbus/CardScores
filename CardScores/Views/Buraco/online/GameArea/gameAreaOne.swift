//Created by Halbus Development

import SwiftUI

struct GameAreaOneView: View {
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(
                            width: proxy.size.width * 0.8,
                            height: proxy.size.height * 0.25
                        )
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(
                            width: proxy.size.width * 0.75,
                            height: proxy.size.height * 0.24
                        )
                }
                .position(
                    x: proxy.size.width * 0.5,
                    y: proxy.size.height * 0.6
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(proxy.safeAreaInsets)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    GameAreaOneView()
}
