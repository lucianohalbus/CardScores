//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @EnvironmentObject var addNewMatchVM: AddNewBuracoFBViewModel
    @StateObject private var loginVM = LoginViewModel()
    @Binding var path: [MainNavigation]
    @State var selectedMatch: BuracoFBViewModel = BuracoFBViewModel(matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [""], myDate: Date(), registeredUser: false, docId: "", gameOver: false))
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
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
                            NavigationLink(value: MainNavigation.child(selectedMatch)) {
                                List {
                                    ForEach(buracoListVM.matchesVM) { matchFB in
                                        BuracoCardView(buracoVM: matchFB)
                                            .padding(.bottom, 10)
                                            .simultaneousGesture(TapGesture().onEnded {
                                                self.addNewMatchVM.createdItem = MatchFB(
                                                    id: matchFB.id,
                                                    scoreToWin: matchFB.scoreToWin,
                                                    playerOne: matchFB.playerOne,
                                                    playerTwo: matchFB.playerTwo,
                                                    playerThree: matchFB.playerThree,
                                                    playerFour: matchFB.playerFour,
                                                    finalScoreOne: matchFB.finalScoreOne,
                                                    finalScoreTwo: matchFB.finalScoreTwo,
                                                    friendsId: matchFB.friendsId,
                                                    myDate: matchFB.myDate,
                                                    registeredUser: matchFB.registeredUser,
                                                    docId: matchFB.docId,
                                                    gameOver: matchFB.gameOver
                                                )
                                            })
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
                            }
                            .navigationDestination(for: MainNavigation.self) { view in
                                switch view {
                                case .child:
                                    BuracoMatchView(matchFB: BuracoFBViewModel(
                                        matchFB: addNewMatchVM.createdItem
                                    ))
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                        
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cardColor)
            .listStyle(.insetGrouped)
            .onAppear {
                buracoListVM.getMatches()
            }
            .onChange(of: loginVM.userAuthenticated) { newValue in
                if newValue {
                    buracoListVM.getMatches()
                }
            }
            .onChange(of: addNewMatchVM.addNewSaved) { newValue in
                if newValue {
                    buracoListVM.getMatches()
                }
            }
        }
    }
}

