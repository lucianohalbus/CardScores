//Created by Halbus Development

import SwiftUI

struct AddNewBuracoMatchView: View {
    @StateObject private var addNewMatchVM = AddNewBuracoFBViewModel()
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
                    addNewMatchVM.add()
                    dismiss()
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(10)
    }
        .navigationTitle("Iniciar uma nova partida")
    }
    
    @ViewBuilder
    private var addNewMatchViewHeader: some View {
        VStack {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.title3)
            TextField("Digite a pontuação", text: $addNewMatchVM.targetScore)
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
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerOne)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerTwo)
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
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerThree)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerFour)
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
