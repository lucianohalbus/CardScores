//Created by Halbus Development

import SwiftUI

struct TopBar: View {
    var body: some View {
        
        GeometryReader { proxy in
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .foregroundColor(Color.black)
                .offset(y: -proxy.size.height * 0.05)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TopBar()
}
