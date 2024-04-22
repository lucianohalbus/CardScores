//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @EnvironmentObject var buracoMatchVM: BuracoMatchViewModel
    @StateObject private var loginVM = LoginViewModel()
    @Binding var path: [MainNavigation]
    @State var selectedMatch: BuracoFBViewModel = BuracoFBViewModel(matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [""], myDate: Date(), registeredUser: false, docId: "", gameOver: false))
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    MiniLogo()
                    
                    VStack {
                        if buracoMatchVM.matchesVM.isEmpty {
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
                            VStack {
                                List {
                                    ForEach(buracoMatchVM.matchesVM) { matchFB in
                                        
                                        Button(action: {
                                            self.buracoMatchVM.createdItem = MatchFB(
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
                                                gameOver: matchFB.gameOver,
                                                imagePath: matchFB.imagePath,
                                                imagePathUrl: matchFB.imagePathUrl
                                            )
                                            
                                            path.append(.child(selectedMatch))
                                        }, label: {
                                            BuracoCardView(buracoVM: matchFB)
                                                .padding(.bottom, 10)
                                        })
                                        
                                    }
                                    .onDelete(perform: { idxSet in
                                        idxSet.forEach { idx in
                                            let match = buracoMatchVM.matchesVM[idx]
                                            buracoMatchVM.delete(matchFB: match)
                                        }
                                    })
                                    .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .listRowBackground(Color.clear)
                                }
                                .listStyle(.plain)
                                .padding(.horizontal, 15)
                                .navigationDestination(for: MainNavigation.self) { view in
                                    switch view {
                                    case .child:
                                        BuracoMatchView(matchFB: BuracoFBViewModel(
                                            matchFB: buracoMatchVM.createdItem
                                        ))
                                    default:
                                        EmptyView()
                                    }
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
            .onAppear {
                buracoMatchVM.getMatches()
            }
            .onChange(of: loginVM.userAuthenticated) { newValue in
                if newValue {
                    buracoMatchVM.getMatches()
                }
            }
            .onChange(of: buracoMatchVM.addNewSaved) { newValue in
                if newValue {
                    buracoMatchVM.getMatches()
                }
            }
        }
    }
}
