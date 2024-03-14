//Created by Halbus Development

import SwiftUI

struct MatchesListView: View {
    @State private var isPresented: Bool = false
    @ObservedObject private var matchFBListVM = MatchFBListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(matchFBListVM.matchesFB) { match in
                       MatchCardView(matchFB: match)
                            .padding(.bottom, 10)
                    }
                    .onDelete(perform: delete(indexSet:))
                    .listRowInsets(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MatchFB.self) { match in
                    MatchResumeView(matchFB: match)
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
                        .sheet(isPresented: $isPresented, content: {
                            AddNewMatchView()
                                .presentationDetents([.fraction(0.6)])
                                .interactiveDismissDisabled()
                        })
                    }
                }
            }
            .navigationTitle("Lista de Partidas")
        }
    }
    
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let match: MatchFB = matchFBListVM.matchesFB[index]
            matchFBListVM.delete(match: match)
        }
    }
    
}

#Preview {
    MatchesListView()
}
