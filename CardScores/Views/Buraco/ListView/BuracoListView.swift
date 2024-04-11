//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @Binding var addNewMatchIsPresented: Bool
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    MiniLogo()
                    
                    Divider()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                    
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
                        }
                        
                        List {
                            ForEach(buracoListVM.matchesVM) { match in
                                BuracoCardView(buracoVM: match)
                                    .padding(.bottom, 10)
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
                        .fullScreenCover(isPresented: $addNewMatchIsPresented, content: {
                            AddNewBuracoMatchView()
                                .interactiveDismissDisabled()
                                .onDisappear(perform: {
                                    buracoListVM.getMatches()
                                })
                        })
                    }
                }
                .navigationDestination(for: BuracoFBViewModel.self) { item in
                    BuracoMatchView(matchFB: item)
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
            }
        }
        .background(Color.cardColor)
    }
}
