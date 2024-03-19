//Created by Halbus Development

import SwiftUI

struct BuracoCardView: View {
    let buracoVM: BuracoFBViewModel
    
    var body: some View {
        NavigationLink(value: buracoVM) {
            VStack {
                Text(buracoVM.myDate, format: Date.FormatStyle(date: .numeric))
                    .foregroundStyle(Color.primary)
                    .font(.title3)
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(buracoVM.playerOne)
                        Text(buracoVM.playerTwo)
                        Text(buracoVM.finalScoreOne.description)
                            .fontWeight(buracoVM.finalScoreOne > buracoVM.finalScoreTwo ? .bold : .regular)
                            .foregroundStyle(Color.cardColor)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(buracoVM.playerThree)
                        Text(buracoVM.playerFour)
                        Text(buracoVM.finalScoreTwo.description)
                            .fontWeight(buracoVM.finalScoreTwo > buracoVM.finalScoreOne ? .bold : .regular)
                            .foregroundStyle(Color.cardColor)
                    }
                }
                .foregroundStyle(Color.black)
                .font(.title3)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
            .padding(.top, 10)
            .background(Color.cardBackgroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.cardColor, lineWidth: 2)
            )
        }
    }
}
