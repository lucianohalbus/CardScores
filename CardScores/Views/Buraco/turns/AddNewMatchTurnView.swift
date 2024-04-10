//Created by Halbus Development

import SwiftUI

struct AddNewMatchTurnView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var buracoTurnsVM = BuracoTurnsViewModel()
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @State private var totalScoreOne: String = ""
    @State private var totalScoreTwo: String = ""
    
    var matchFB: BuracoFBViewModel
    @State var cardScoreOne: Int? = nil
    @State var canastraScoreOne: Int? = nil
    @State var negativeScoreOne: Int? = nil
    @State var cardScoreTwo: Int? = nil
    @State var canastraScoreTwo: Int? = nil
    @State var negativeScoreTwo: Int? = nil
    
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
                            dbScore: Int(buracoListVM.scoreOne) ?? 0,
                            canastraScore: self.canastraScoreOne ?? 0,
                            cardScore: self.cardScoreOne ?? 0,
                            negativeScore: self.negativeScoreOne ?? 0
                        )
                        
                        buracoListVM.scoreOne = calculatedTotalScoreOne.description
                        
                        let calculatedTotalScoreTwo: Int = buracoTurnsVM.calculateTotalScore(
                            dbScore: Int(buracoListVM.scoreTwo) ?? 0,
                            canastraScore: self.canastraScoreTwo ?? 0,
                            cardScore: self.cardScoreTwo ?? 0,
                            negativeScore: self.negativeScoreTwo ?? 0
                        )
                        buracoListVM.scoreTwo = calculatedTotalScoreTwo.description
                        
                        let partialScoreOne: Int = buracoTurnsVM.calculatePartialScore(
                            canastraScore: self.canastraScoreOne ?? 0,
                            cardScore: self.cardScoreOne ?? 0,
                            negativeScore: self.negativeScoreOne ?? 0
                        )
                        
                        let partialScoreTwo: Int = buracoTurnsVM.calculatePartialScore(
                            canastraScore: self.canastraScoreTwo ?? 0,
                            cardScore: self.cardScoreTwo ?? 0,
                            negativeScore: self.negativeScoreTwo ?? 0
                        )
                        
                        let match: MatchFB = MatchFB(
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
                        
                        buracoListVM.update(matchId: matchFB.id, matchFB: match)
                        
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
            
            Text("Pontos de Canastras")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $canastraScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $cardScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $negativeScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
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
            
            Text("Pontos de Canastras")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $canastraScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $cardScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .foregroundStyle(Color.white)
                .font(.caption)
            
            TextField("Pontos", value: $negativeScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.trailing)
    }
    
    private func checkGameOver(_ scoreOne: Int, _ scoreTwo: Int, _ scoreToWin: Int) -> Bool {
        if scoreOne >= scoreToWin ||
            scoreTwo >= scoreToWin {
            buracoListVM.gameOver = true
            return true
        } else {
            return false
        }
        
    }

}
