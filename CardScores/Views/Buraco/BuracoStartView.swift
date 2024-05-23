//Created by Halbus Development

import SwiftUI

struct BuracoStartView: View {
    @Binding var path: [MainNavigation]
    enum SelectBuracoStyleGame: String, CodingKey, CaseIterable {
        case presencial = "Regular"
        case online = "Online"
    }
    
    @State var selectedBuracoStyleGame: SelectBuracoStyleGame = .presencial
    
    var body: some View {
        ZStack {
            VStack {
                
                MiniLogo()
                
                Picker("Select Game Style", selection: $selectedBuracoStyleGame) {
                    ForEach(SelectBuracoStyleGame.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .font(.title)
                .fontWeight(.bold)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal, 35)
                .padding(.bottom, 20)
                .pickerStyle(.segmented)
                
                switch self.selectedBuracoStyleGame {
                case .presencial:
                    BuracoPresencialStartView(path: $path)
                    
                case .online:
                    BuracoOnlineStartView(path: $path)
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
    }
}
