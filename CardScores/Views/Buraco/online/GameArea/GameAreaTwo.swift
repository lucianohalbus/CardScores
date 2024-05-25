//Created by Halbus Development

import SwiftUI

struct GameAreaTwoView: View {

    var body: some View {
        GeometryReader { proxy in
            HStack {
                Rectangle()
                    .frame(width: 100, height: 200)
                    .foregroundColor(Color.clear)
                
                VStack {
                    Rectangle()
                        .frame(width: 100, height: 300)
                        .foregroundColor(Color.clear)
  
                }
            }

            .frame(width: proxy.size.width * 0.65, height: proxy.size.height * 0.3)
            .border(.red)
            
            .offset(x: proxy.size.width * 0.17, y: proxy.size.height * 0.5)
            
        }
    }
}


#Preview {
    GameAreaTwoView()
}
