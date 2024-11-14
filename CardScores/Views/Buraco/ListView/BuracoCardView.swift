//Created by Halbus Development

import SwiftUI

struct BuracoCardView: View {
    let buracoVM: BuracoFBViewModel

    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(value: buracoVM) { }
            
            Text(buracoVM.myDate, format: Date.FormatStyle(date: .numeric))
                .foregroundStyle(Color.black)
                .font(.title3)
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text(buracoVM.playerOne)
                    Text(buracoVM.playerTwo)
                    Text(buracoVM.finalScoreOne.description)
                        .foregroundStyle(Int(buracoVM.finalScoreOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoVM.finalScoreOne) ?? 0 > Int(buracoVM.finalScoreTwo) ?? 0 ? .bold : .regular)
                }
                .minimumScaleFactor(0.4)
                .lineLimit(1)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(buracoVM.playerThree)
                    Text(buracoVM.playerFour)
                    Text(buracoVM.finalScoreTwo.description)
                        .foregroundStyle(Int(buracoVM.finalScoreTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoVM.finalScoreTwo) ?? 0 > Int(buracoVM.finalScoreOne) ?? 0 ? .bold : .regular)
                }
                .minimumScaleFactor(0.4)
                .lineLimit(1)
            }
            .foregroundStyle(Color.black)
            .font(.title3)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .background(Color.cardBackgroundColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }
}

#Preview {
    BuracoCardView(buracoVM: BuracoFBViewModel(matchFB: MatchFB(id: "1", scoreToWin: "10", playerOne: "Zico", playerTwo: "Leandro", playerThree: "Junior", playerFour: "Savio", finalScoreOne: "1000", finalScoreTwo: "400", friendsId: [], myDate: Date(), registeredUser: true, docId: "1", gameOver: false)))
}
