//Created by Halbus Development

import SwiftUI

struct BuracoMatchView: View {
    var matchFB: BuracoFBViewModel
    @State private var presentAddNewMatchTurnView: Bool = false
    @ObservedObject private var buracoListVM = BuracoListViewModel()
    @StateObject private var buracoTurnVM = BuracoTurnsViewModel()
    
    var body: some View {
        VStack {
            
            matchResumeViewHeader
                .padding(.bottom, 20)
            
            ScrollView {
                if !buracoTurnVM.turns.isEmpty {
                    matchResumeViewList
                }
                
                if !matchFB.gameOver {
                    
                    Button {
                        
                        presentAddNewMatchTurnView.toggle()
                        
                    } label: {
                        Text("Adinonar nova rodada")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.cardColor)
                            .cornerRadius(20)
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding(.top, 20)
                    }
                    .sheet(isPresented: $presentAddNewMatchTurnView, content: {
                        
                        AddNewMatchTurnView(matchFB: matchFB)
                            .presentationDetents([.fraction(0.7)])
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
        })
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.gray, lineWidth: 5)
        )
        
    }
    
    @ViewBuilder
    private var matchResumeViewHeader: some View {
        VStack {
            Text(!matchFB.gameOver ? "Pontuação" : "Partida Encerrada")
                .font(.title)
                .foregroundColor(.cardColor)
                .bold()
            
            HStack {
                
                VStack (alignment: .leading) {
                    Text(matchFB.playerOne)
                    Text(matchFB.playerTwo)
                    Text(matchFB.finalScoreOne)
                        .foregroundStyle(Color.cardColor)
                        .bold()
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
                    Text(matchFB.finalScoreTwo)
                        .foregroundStyle(Color.cardColor)
                        .bold()
                }
                .foregroundStyle(Color.black)
            }
            .font(.title)
            .foregroundColor(.white)
            .padding(15)
            .background(Color.textViewBackgroundColor)
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
                                Text(matchResume.scoresTurnOne)
                            }
                            .frame(width: 50, alignment: .leading)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.myTime.formatted(date: .abbreviated, time: .shortened))
                            }
                            .frame(width: 180, alignment: .center)
                            
                            Spacer()
                            
                            VStack {
                                Text(matchResume.scoresTurnTwo)
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
                    .stroke(Color.cardColor, lineWidth: 2)
            )
        }
    }
}
