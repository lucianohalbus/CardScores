//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var addNewBuracoVM = AddNewBuracoFBViewModel()
    
    @State private var path = NavigationPath()
    @State var createdMMatch: BuracoFBViewModel = BuracoFBViewModel(matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [""], myDate: Date(), registeredUser: false, docId: "", gameOver: false))

    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                VStack {
                    MiniLogo()
                    
                    VStack {
                        if buracoListVM.matchesVM.isEmpty {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 380, height: 130)
                                    .foregroundColor(Color.cardBackgroundColor)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .inset(by: 2)
                                            .stroke(Color.cardColor, lineWidth: 2)
                                    )
                                
                                
                                VStack {
                                    Text("Você ainda não")
                                    Text("tem partidas salvas")
                                }
                                .foregroundColor(Color.cardColor)
                                .font(.headline)
                            }
                        } else {
                            List {
                                ForEach(buracoListVM.matchesVM) { matchFB in
                                    Button {
                                        addNewBuracoVM.createdMMatch =  matchFB
                                        path.append("BuracoMatchView")
                                    } label: {
                                        BuracoCardView(buracoVM: matchFB)
                                            .padding(.bottom, 10)
                                    }
                                }
                                .onDelete(perform: { idxSet in
                                    idxSet.forEach { idx in
                                        let match = buracoListVM.matchesVM[idx]
                                        buracoListVM.delete(matchFB: match)
                                    }
                                })
                                .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.clear)
                                
                            }
                            .scrollContentBackground(.hidden)
                        }
                        
                        Spacer()
                    }
                }
                .navigationDestination(for: String.self) { view in
                    if view == "BuracoMatchView" {
                        
                        BuracoMatchView(matchFB: BuracoFBViewModel(matchFB:
                            MatchFB(
                                id: addNewBuracoVM.createdMMatch.id,
                                scoreToWin: addNewBuracoVM.createdMMatch.scoreToWin,
                                playerOne: addNewBuracoVM.createdMMatch.playerOne,
                                playerTwo: addNewBuracoVM.createdMMatch.playerTwo,
                                playerThree: addNewBuracoVM.createdMMatch.playerThree,
                                playerFour: addNewBuracoVM.createdMMatch.playerFour,
                                finalScoreOne: addNewBuracoVM.createdMMatch.finalScoreOne,
                                finalScoreTwo: addNewBuracoVM.createdMMatch.finalScoreTwo,
                                friendsId: addNewBuracoVM.createdMMatch.friendsId,
                                myDate: addNewBuracoVM.createdMMatch.myDate,
                                registeredUser: addNewBuracoVM.createdMMatch.registeredUser,
                                docId: addNewBuracoVM.createdMMatch.docId,
                                gameOver: addNewBuracoVM.createdMMatch.gameOver
                            )
                        ))
                    }
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    buracoListVM.getMatches()
                }
                .onChange(of: loginVM.userAuthenticated) { newValue in
                    if newValue {
                        buracoListVM.getMatches()
                    }
                }
                .onChange(of: addNewBuracoVM.addNewSaved) { newValue in
                    if newValue {
                        buracoListVM.getMatches()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
    }
}
