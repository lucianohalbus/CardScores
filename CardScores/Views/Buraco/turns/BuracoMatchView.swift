//Created by Halbus Development

import SwiftUI

struct BuracoMatchView: View {
    var matchFB: BuracoFBViewModel
    @State private var presentAddNewMatchTurnView: Bool = false
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var buracoTurnVM = BuracoTurnsViewModel()
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
                .padding(.bottom, 20)
            
            ScrollView {
                if !buracoTurnVM.turns.isEmpty {
                    matchResumeViewList
                }
                
                if !buracoListVM.gameOver {
                    
                    Button {
                        
                        presentAddNewMatchTurnView.toggle()
                        
                    } label: {
                        Text("Adinonar pontos da rodada")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.cardColor)
                            .cornerRadius(20)
                            .foregroundStyle(Color.white)
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                        
                        AddNewMatchTurnView(matchFB: matchFB)
                            .interactiveDismissDisabled()
                            .onDisappear(perform: {
                                buracoTurnVM.getTurn()
                                buracoListVM.getMatches()
                            })
                    })
                    
                }
            }
        }
        .padding()
        .onAppear(perform: {
            buracoTurnVM.getTurn()
            buracoListVM.scoreOne = matchFB.finalScoreOne
            buracoListVM.scoreTwo = matchFB.finalScoreTwo
            buracoListVM.gameOver = matchFB.gameOver
        })
    }
    
    @ViewBuilder
    private var matchResumeViewHeader: some View {
        VStack {
            Text(!buracoListVM.gameOver ? "Partida Em Andamento" : "Partida Encerrada")
                .font(.title)
                .foregroundColor(.cardColor)
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text(matchFB.playerOne)
                    Text(matchFB.playerTwo)
                    Text(buracoListVM.scoreOne)
                        .foregroundStyle(Int(buracoListVM.scoreOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreOne) ?? 0 > Int(buracoListVM.scoreTwo) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
                
                Spacer()
                
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.white)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(matchFB.playerThree)
                    Text(matchFB.playerFour)
                    Text(buracoListVM.scoreTwo)
                        .foregroundStyle(Int(buracoListVM.scoreTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                        .fontWeight(Int(buracoListVM.scoreTwo) ?? 0 > Int(buracoListVM.scoreOne) ?? 0 ? .bold : .regular)
                }
                .foregroundStyle(Color.black)
            }
            .font(.title)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.cardBackgroundColor)
            .cornerRadius(20)
        }
    }
    
    @ViewBuilder
    private var matchResumeViewList: some View {
        VStack(spacing: 5) {
            Text("Pontuação das Rodadas")
                .font(.title2)
                .foregroundColor(.cardColor)
            
            VStack {
                ForEach(buracoTurnVM.turns) { matchResume in
                    if matchResume.turnId == matchFB.id {
                        
                        HStack(spacing: 5) {
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnOne) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnOne) ?? 0 < 0 ? Color.red : Color.cardColor)
                            }
                            .frame(width: 50, alignment: .leading)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.myTime.formatted(date: .abbreviated, time: .shortened))
                            }
                            .frame(width: 180, alignment: .center)
                            
                            Spacer()
                            
                            VStack {
                                Text("\(abs(Int(matchResume.scoresTurnTwo) ?? 0))")
                                    .foregroundStyle(Int(matchResume.scoresTurnTwo) ?? 0 < 0 ? Color.red : Color.cardColor)
                            }
                            .frame(width: 50, alignment: .trailing)
                            
                        }
                        .font(.callout)
                        .padding(.horizontal, 15)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 10)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.textFieldBorderColor, lineWidth: 2)
            )
        }
    }
}
