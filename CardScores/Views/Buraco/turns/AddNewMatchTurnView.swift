//Created by Halbus Development

import SwiftUI

struct AddNewMatchTurnView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var buracoTurnsVM = BuracoTurnsViewModel()
    var matchFB: BuracoFBViewModel
    @State private var gameOver: Bool = false
    
    init(matchFB: BuracoFBViewModel) {
        self.matchFB = matchFB
    }
    
    private var isValid: Bool {
        buracoTurnsVM.cardScoreOne != nil  &&
        buracoTurnsVM.cardScoreTwo != nil  &&
        buracoTurnsVM.canastraScoreOne != nil  &&
        buracoTurnsVM.canastraScoreTwo != nil  &&
        buracoTurnsVM.negativeScoreOne != nil  &&
        buracoTurnsVM.negativeScoreTwo != nil
    }

    var body: some View {
        VStack {
            if !matchFB.gameOver {
                Group {
                    VStack {
            
                        Text("Digite a Pontuação da Rodada")
                            .font(.title2)
                            .bold()
                            .padding(.top, 10)
                        
                        Text("Preencha todos os campos")
                            .font(.title3)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.cardColor)
                            .padding(.vertical, 10)
                        
                        HStack {

                            scoresLeftSide
                            
                            Divider()
                                .frame(width: 1, height: 300)
                                .background(Color.cardColor)
                            
                            scoresRightSide

                        }
                        
                    }
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 2)
                            .stroke(Color.cardColor, lineWidth: 2)
                    )
                    .padding(.horizontal, 5)
                    
                }
                .textFieldStyle(.roundedBorder)
                
                HStack {
                    
                    Spacer()
                    
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        
//                        let totalScoreOne: Int = calculateTotalScore(
//                            dbScore: Int(matchFB.finalScoreOne) ?? 0,
//                            canastraScore: buracoTurnsVM.canastraScoreOne ?? 0,
//                            cardScore: buracoTurnsVM.cardScoreOne ?? 0,
//                            negativeScore: buracoTurnsVM.negativeScoreOne ?? 0
//                        )
//                        
//                        
//
//                        let totalScoreTwo: Int = calculateTotalScore(
//                            dbScore: Int(matchFB.finalScoreTwo) ?? 0,
//                            canastraScore: buracoTurnsVM.canastraScoreTwo ?? 0,
//                            cardScore: buracoTurnsVM.cardScoreTwo ?? 0,
//                            negativeScore: buracoTurnsVM.negativeScoreTwo ?? 0
//                        )
//
//                        if totalScoreOne >= Int(matchFB.scoreToWin) ?? 0 || totalScoreTwo >=  Int(matchFB.scoreToWin) ?? 0 {
//                            self.gameOver = true
//                        }
//                        
                        do {
//                            
//                            let partialScoreTeamOne: Int = calculatePartialScore(
//                                canastraScore: buracoTurnsVM.canastraScoreOne ?? 0,
//                                cardScore: buracoTurnsVM.cardScoreOne ?? 0,
//                                negativeScore: buracoTurnsVM.negativeScoreOne ?? 0
//                            )
//                            
//                            let partialScoreTeamTwo: Int = calculatePartialScore(
//                                canastraScore: buracoTurnsVM.canastraScoreTwo ?? 0,
//                                cardScore: buracoTurnsVM.cardScoreTwo ?? 0,
//                                negativeScore: buracoTurnsVM.negativeScoreTwo ?? 0
//                            )
//                            
//                            let matchTurn: MatchTurn = MatchTurn(
//                                myTime: Date(),
//                                scoresTurnOne: partialScoreTeamOne.description,
//                                scoresTurnTwo: partialScoreTeamTwo.description,
//                                turnId: matchFB.id ?? "",
//                                friendsId: matchFB.friendsId
//                            )
//                            
//                            let matchFB: MatchFB = MatchFB(
//                                scoreToWin: matchFB.scoreToWin,
//                                playerOne: matchFB.playerOne,
//                                playerTwo: matchFB.playerTwo,
//                                playerThree: matchFB.playerThree,
//                                playerFour: matchFB.playerFour,
//                                finalScoreOne: self.scoreTeamOne?.description ?? "",
//                                finalScoreTwo: self.scoreTeamTwo?.description ?? "",
//                                friendsId: matchFB.friendsId,
//                                myDate: matchFB.myDate,
//                                registeredUser: matchFB.registeredUser,
//                                docId: matchFB.docId,
//                                gameOver: self.gameOver
//                            )
                           
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        dismiss()
                    }
                    .buttonStyle(.bordered)
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
    
    private var scoresLeftSide: some View {
        VStack(alignment: .leading) {
            Text(matchFB.playerOne)
                .font(.title2)
                .bold()
            
            Text(matchFB.playerTwo)
                .font(.title2)
                .bold()
            
            Text(matchFB.finalScoreOne)
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            Text("Pontos de Canastras")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.canastraScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.cardScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.negativeScoreOne, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.leading)
    }
    
    private var scoresRightSide: some View {
        VStack(alignment: .trailing) {
            Text(matchFB.playerThree)
                .font(.title2)
                .bold()
            
            Text(matchFB.playerFour)
                .font(.title2)
                .bold()
            
            Text(matchFB.finalScoreTwo)
                .font(.title2)
                .bold()
                .padding(.bottom, 10)
            
            Text("Pontos de Canastras")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.canastraScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos das Cartas")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.cardScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
            
            Text("Pontos à descontar")
                .font(.headline)
            
            TextField("Pontos", value: $buracoTurnsVM.negativeScoreTwo, format: .number)
                .keyboardType(.numberPad)
                .padding(.bottom, 20)
        }
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.trailing)
    }

}
