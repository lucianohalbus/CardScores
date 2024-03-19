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
                .foregroundStyle(Color.cardColor)
                .bold()
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
            Text("Pontuação Mínima de Vitória")
                .font(.title3)
                .foregroundStyle(Color.cardColor)
            TextField("Digite a pontuação", text: $addNewMatchVM.targetScore)
                .frame(width: 100)
                .cornerRadius(10)
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
    }
    
    @ViewBuilder
    private var addNewMatchViewTeams: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dupla 1")
                    .font(.title)
                    .foregroundStyle(Color.cardColor)
                
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerOne)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                    
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerTwo)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
            }
            .multilineTextAlignment(TextAlignment.leading)
            .textFieldStyle(.roundedBorder)
            
            VStack {
                Text("")
            }
            .frame(width: 30)
            
            VStack(alignment: .trailing) {
                Text("Dupla 2")
                    .font(.title)
                    .foregroundStyle(Color.cardColor)
                
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerThree)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerFour)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
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
