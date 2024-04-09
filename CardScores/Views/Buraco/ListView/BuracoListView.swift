//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @Binding var addNewMatchIsPresented: Bool
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
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
            .background(Color.cardColor)
        }
    }
}
