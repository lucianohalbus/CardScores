//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @State private var isPresented: Bool = false
    @StateObject private var buracoListVM = BuracoListViewModel()
    @ObservedObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if loginVM.loggedUser {
                    VStack {
                        List {
                            ForEach(buracoListVM.maches) { match in
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
                            .sheet(isPresented: $isPresented, content: {
                                //                        AddNewMatchView()
                                //                            .interactiveDismissDisabled()
                            })
                        }
                        .scrollContentBackground(.hidden)
                        .navigationDestination(for: MatchFB.self) { match in
                            BuracoMatchView(matchFB: match)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    isPresented.toggle()
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .foregroundStyle(Color.white, Color.white)
                                        .bold()
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.trailing, 20)
                                .tint(Color.cardColor)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Lista de Partidas")
                    .onAppear {
                        buracoListVM.getMatches()
                    }
                } else {
                    EmptyView()
                }
                
            }
        }
    }
    
//    private func delete(indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let match: MatchFB = matchFBListVM.matchesFB[index]
//            matchFBListVM.delete(match: match, index: obtainingTheRowNumber(indexSet: indexSet))
//        }
//    }
    
//    private func delete(indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let match: MatchFB = matchFBListVM.matchesFB[index]
//            matchFBListVM.delete(match: match, index: obtainingTheRowNumber(indexSet: indexSet))
//        }
//    }
    
    private func obtainingTheRowNumber(indexSet: IndexSet) -> Int{
            return indexSet[indexSet.startIndex]
        }
    
}

#Preview {
    BuracoListView()
}
