//Created by Halbus Development

import SwiftUI

struct BuracoCardView: View {
    let buracoVM: BuracoFBViewModel
    
    var body: some View {
        NavigationLink(value: buracoVM) {
            VStack {
                Text(buracoVM.myDate, format: Date.FormatStyle(date: .numeric))
                    .foregroundStyle(Color.primary)
                    .font(.title2)
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(buracoVM.playerOne)
                        Text(buracoVM.playerTwo)
                        Text(buracoVM.finalScoreOne.description)
                            .foregroundStyle(buracoVM.finalScoreOne >= buracoVM.finalScoreTwo ? Color.green : Color.red)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(buracoVM.playerThree)
                        Text(buracoVM.playerFour)
                        Text(buracoVM.finalScoreTwo.description)
                            .foregroundStyle(buracoVM.finalScoreTwo >= buracoVM.finalScoreOne ? Color.green : Color.red)
                    }
                }
                .foregroundStyle(Color.primary)
                .font(.title2)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
            .padding(.top, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.cardColor, lineWidth: 2)
            )
        }
    }
}
