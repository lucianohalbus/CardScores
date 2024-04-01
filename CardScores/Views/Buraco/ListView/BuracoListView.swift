//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoListView: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject var buracoListVM: BuracoListViewModel
    @StateObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationStack {
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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .bold()
                        }
                        .buttonStyle(.borderless)
                        .padding(.trailing, 20)
                        .tint(Color.cardColor)
                        .sheet(isPresented: $isPresented, content: {
                            AddNewBuracoMatchView()
                                .interactiveDismissDisabled()
                                .onDisappear(perform: {
                                    buracoListVM.getMatches()
                                })
                        })
                    }
                }
            }
            .navigationDestination(for: BuracoFBViewModel.self) { item in
                BuracoMatchView(matchFB: item)
                    .navigationTitle("")
            }
            .listStyle(.insetGrouped)
            .onAppear {
                buracoListVM.getMatches()
            }
            .onChange(of: loginVM.userAuthenticated) { oldValue, newValue in
                if newValue {
                    buracoListVM.getMatches()
                }
            }
        }
    }
}
