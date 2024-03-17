//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct AddNewBuracoMatchView: View {
    @ObservedObject private var buracoListVM = BuracoListViewModel()
    @ObservedObject private var addNewBuracoMatchVM = AddNewBuracoFBViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
        VStack {
            Text("Criar Nova Partida")
                .font(.title2)
                .foregroundStyle(Color.primary)
                .padding(.bottom, 20 )
            
            addNewMatchViewHeader
                .padding(.bottom, 10)
            
            addNewMatchViewTeams
                .padding(.bottom, 20)
            
            HStack {
                
                Spacer()
                
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Save") {
                   addNewBuracoMatchVM.add(match: MatchFB(scoreToWin: addNewBuracoMatchVM.targetScore, playerOne: addNewBuracoMatchVM.playerOne, playerTwo: addNewBuracoMatchVM.playerTwo, playerThree: addNewBuracoMatchVM.playerThree, playerFour: addNewBuracoMatchVM.playerThree, finalScoreOne: "0", finalScoreTwo: "0", friendsId: [Auth.auth().currentUser?.uid ?? ""], myDate: Date(), registeredUser: false, docId: "", gameOver: false))
                }
                .buttonStyle(.bordered)
                .onChange(of: addNewBuracoMatchVM.addNewSaved) {
                    if  addNewBuracoMatchVM.addNewSaved{
                        dismiss()
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(10)
        .onDisappear(perform: {
            buracoListVM.getMatches()
        })
    }
        .navigationTitle("Iniciar uma nova partida")
    }
    
    @ViewBuilder
    private var addNewMatchViewHeader: some View {
        VStack {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.title3)
            TextField("Digite a pontuação", text: $addNewBuracoMatchVM.targetScore)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(TextAlignment.center)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.textFieldBorderColor)
                )
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }
    
    @ViewBuilder
    private var addNewMatchViewTeams: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dupla 1")
                    .font(.title)
                TextField("Nome do Jogador 1", text: $addNewBuracoMatchVM.playerOne)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $addNewBuracoMatchVM.playerTwo)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
            }
            .multilineTextAlignment(TextAlignment.leading)
            .textFieldStyle(.roundedBorder)
            
            VStack(alignment: .trailing) {
                Text("Dupla 2")
                    .font(.title)
                TextField("Nome do Jogador 1", text: $addNewBuracoMatchVM.playerThree)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $addNewBuracoMatchVM.playerFour)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
            }
            .multilineTextAlignment(TextAlignment.trailing)
            .textFieldStyle(.roundedBorder)
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 2)
                .stroke(Color.cardColor, lineWidth: 2)
        )
    }

}
