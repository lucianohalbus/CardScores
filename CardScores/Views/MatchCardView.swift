//Created by Halbus Development

import SwiftUI

struct MatchCardView: View {
    let matchFB: MatchFB
    
    var body: some View {
        NavigationLink(value: matchFB) {
            VStack {
                Text(matchFB.myDate, format: Date.FormatStyle(date: .numeric))
                    .foregroundStyle(Color.primary)
                    .font(.title2)
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(matchFB.playerOne)
                        Text(matchFB.playerTwo)
                        Text(matchFB.finalScoreOne.description)
                            .foregroundStyle(matchFB.finalScoreOne >= matchFB.finalScoreTwo ? Color.green : Color.red)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(matchFB.playerThree)
                        Text(matchFB.playerFour)
                        Text(matchFB.finalScoreTwo.description)
                            .foregroundStyle(matchFB.finalScoreTwo >= matchFB.finalScoreOne ? Color.green : Color.red)
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
