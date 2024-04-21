//Created by Halbus Development

import SwiftUI

struct AddNewMatchTurnView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var buracoTurnsVM: BuracoTurnsViewModel
    @EnvironmentObject var buracoMatchVM: BuracoMatchViewModel
    
    var matchFB: BuracoFBViewModel
    
    @State private var totalScoreOne: String = ""
    @State private var totalScoreTwo: String = ""
    @State var cardScoreOne: Int? = nil
    @State var canastraScoreOne: Int? = nil
    @State var negativeScoreOne: Int? = nil
    @State var cardScoreTwo: Int? = nil
    @State var canastraScoreTwo: Int? = nil
    @State var negativeScoreTwo: Int? = nil
    @State var goodDistributorOne: Bool = false
    @State var goodDistributorTwo: Bool = false
    
    init(matchFB: BuracoFBViewModel) {
        self.matchFB = matchFB
    }
    
    private var isValid: Bool {
        self.cardScoreOne != nil  &&
        self.cardScoreTwo != nil  &&
        self.canastraScoreOne != nil  &&
        self.canastraScoreTwo != nil  &&
        self.negativeScoreOne != nil  &&
        self.negativeScoreTwo != nil
    }

    var body: some View {
        ZStack {
        VStack {
            if !matchFB.gameOver {
                Group {
                    VStack {
                        
                        Text("Digite a Pontuação da Rodada")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding(.top, 10)
                        
                        Text("Preencha todos os campos")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.white)
                            .padding(.vertical, 10)
                        
                        HStack {
                            
                            scoresLeftSide
                            
                            Divider()
                                .frame(width: 1, height: 300)
                                .background(Color.white)
                            
                            scoresRightSide
                            
                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 2)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .padding(.horizontal, 5)
                    
                }
                .textFieldStyle(.roundedBorder)
                
                HStack {
                    
                    Spacer()
                    
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.green.opacity(0.9))
                    .controlSize(.regular)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        let calculatedTotalScoreOne: Int = buracoTurnsVM.calculateTotalScore(
                            dbScore: Int(buracoMatchVM.scoreOne) ?? 0,
                            canastraScore: self.canastraScoreOne ?? 0,
                            cardScore: self.cardScoreOne ?? 0,
                            negativeScore: self.negativeScoreOne ?? 0,
                            goodDistributor: goodDistributorOne
                        )
                        
                        buracoMatchVM.scoreOne = calculatedTotalScoreOne.description
                        
                        let calculatedTotalScoreTwo: Int = buracoTurnsVM.calculateTotalScore(
                            dbScore: Int(buracoMatchVM.scoreTwo) ?? 0,
                            canastraScore: self.canastraScoreTwo ?? 0,
                            cardScore: self.cardScoreTwo ?? 0,
                            negativeScore: self.negativeScoreTwo ?? 0,
                            goodDistributor: goodDistributorTwo
                        )
                        buracoMatchVM.scoreTwo = calculatedTotalScoreTwo.description
                        
                        let partialScoreOne: Int = buracoTurnsVM.calculatePartialScore(
                            canastraScore: self.canastraScoreOne ?? 0,
                            cardScore: self.cardScoreOne ?? 0,
                            negativeScore: self.negativeScoreOne ?? 0, 
                            goodDistributor: goodDistributorOne
                        )
                        
                        let partialScoreTwo: Int = buracoTurnsVM.calculatePartialScore(
                            canastraScore: self.canastraScoreTwo ?? 0,
                            cardScore: self.cardScoreTwo ?? 0,
                            negativeScore: self.negativeScoreTwo ?? 0,
                            goodDistributor: goodDistributorTwo
                        )
                        
                        let match: MatchFB = MatchFB(
                            id: matchFB.id,
                            scoreToWin: matchFB.scoreToWin,
                            playerOne: matchFB.playerOne,
                            playerTwo: matchFB.playerTwo,
                            playerThree: matchFB.playerThree,
                            playerFour: matchFB.playerFour,
                            finalScoreOne: calculatedTotalScoreOne.description,
                            finalScoreTwo: calculatedTotalScoreTwo.description,
                            friendsId: matchFB.friendsId,
                            myDate: matchFB.myDate,
                            registeredUser: matchFB.registeredUser,
                            docId: matchFB.id,
                            gameOver: checkGameOver(calculatedTotalScoreOne, calculatedTotalScoreTwo, Int(matchFB.scoreToWin) ?? 3000) ? true : false,
                            imagePath: matchFB.imagePath,
                            imagePathUrl: matchFB.imagePathUrl
    
                        )
                        
                        buracoMatchVM.update(matchId: matchFB.id, matchFB: match)
                        
                        buracoTurnsVM.addTurn(matchTurn: MatchTurn(
                            myTime: Date(),
                            scoresTurnOne: partialScoreOne.description,
                            scoresTurnTwo: partialScoreTwo.description,
                            turnId: matchFB.id,
                            friendsId: matchFB.friendsId
                        ))
                        
                        dismiss()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.green.opacity(0.9))
                    .controlSize(.regular)
                    .buttonStyle(.borderedProminent)
                    .disabled(!isValid)
                    
                    Spacer()
                }
            } else {
                VStack {
                    Text("Pontuação de Vitória")
                    Text(matchFB.scoreToWin)
                    
                    HStack {
                        VStack {
                            Text(matchFB.playerOne)
                            Text(matchFB.playerTwo)
                            Text(matchFB.finalScoreOne)
                        }
                        
                        VStack {
                            Text(matchFB.playerThree)
                            Text(matchFB.playerFour)
                            Text(matchFB.finalScoreTwo)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(20)
    }
        .background(Color.cardColor)
    }
    
    private var scoresLeftSide: some View {
        VStack(alignment: .leading) {
            Text(matchFB.playerOne)
                .font(.caption)
                .foregroundStyle(Color.white)
                .bold()
            
            Text(matchFB.playerTwo)
                .font(.caption)
                .foregroundStyle(Color.white)
                .bold()
            
            Text(matchFB.finalScoreOne)
                .font(.caption)
                .foregroundStyle(Int(matchFB.finalScoreOne) ?? 0 >= 0 ? Color.white : Color.red)
                .bold()
                .padding(.bottom, 10)

                Toggle(isOn: $goodDistributorOne, label: {
                    Text("+100")
                        .padding(.horizontal)
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .frame(width: 130, alignment: .leading)
                        
                })
                .frame(width: 155)
                .toggleStyle(SwitchToggleStyle(tint: .yellow))
                .scaleEffect(0.8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 2)
                        .stroke(Color.white, lineWidth: 2)
                )
                .padding(.bottom, 15)

            Text("Pontos à descontar")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Descontar", value: $negativeScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
            Text("Pontos de Canastras")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Canastras", value: $canastraScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
            Text("Pontos das Cartas")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Cartas", value: $cardScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.leading)
    }
    
    private var scoresRightSide: some View {
        VStack(alignment: .trailing) {
            Text(matchFB.playerThree)
                .font(.caption)
                .foregroundStyle(Color.white)
                .bold()
            
            Text(matchFB.playerFour)
                .font(.caption)
                .foregroundStyle(Color.white)
                .bold()
            
            Text(matchFB.finalScoreTwo)
                .font(.caption)
                .foregroundStyle(Int(matchFB.finalScoreOne) ?? 0 >= 0 ? Color.white : Color.red)
                .bold()
                .padding(.bottom, 10)
            
            Toggle(isOn: $goodDistributorTwo, label: {
                Text("+100")
                    .padding(.horizontal)
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .frame(width: 130, alignment: .leading)
                    
            })
            .frame(width: 155)
            .toggleStyle(SwitchToggleStyle(tint: .yellow))
            .scaleEffect(0.8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 2)
                    .stroke(Color.white, lineWidth: 2)
            )
            .padding(.bottom, 15)
            
            Text("Pontos à descontar")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Descontar", value: $negativeScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
            Text("Pontos de Canastras")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Canastras", value: $canastraScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
            
            Text("Pontos das Cartas")
                .foregroundStyle(Color.white)
                .font(.caption)
            TextField("Cartas", value: $cardScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 15)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.trailing)
    }
    
    private func checkGameOver(_ scoreOne: Int, _ scoreTwo: Int, _ scoreToWin: Int) -> Bool {
        if scoreOne >= scoreToWin ||
            scoreTwo >= scoreToWin {
            buracoMatchVM.gameOver = true
            return true
        } else {
            return false
        }
        
    }

}

#Preview {
    AddNewMatchTurnView(matchFB: BuracoFBViewModel(matchFB: MatchFB(
        id: "",
        scoreToWin: "",
        playerOne: "Zico",
        playerTwo: "Sócrates",
        playerThree: "Falcão",
        playerFour: "Cerezo",
        finalScoreOne: "500",
        finalScoreTwo: "100",
        friendsId: [],
        myDate: Date(),
        registeredUser: false,
        docId: "",
        gameOver: false,
        profileImagePathUrl: URL(string: ""),
        imagePath: "",
        imagePathUrl: ""
    )))
}
