//Created by Halbus Development

import SwiftUI

struct AddNewBuracoMatchView: View {
    @StateObject private var addNewMatchVM = AddNewBuracoFBViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                MiniLogo()
                
                Text("Criar Nova Partida")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding(.bottom, 10 )
                
                addNewMatchViewHeader
                
                addNewMatchViewTeams
                
                HStack {
                    
                    Spacer()
                    
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.green.opacity(0.9))
                    .controlSize(.regular)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    Button("Save") {
                        addNewMatchVM.add()
                        dismiss()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.green.opacity(0.9))
                    .controlSize(.regular)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .background(Color.cardColor)
    }
    
    @ViewBuilder
    private var addNewMatchViewHeader: some View {
        VStack(spacing: 0) {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.headline)
                .foregroundStyle(Color.white)
            TextField("Digite a pontuação", text: $addNewMatchVM.targetScore)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(TextAlignment.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
    }
    
    @ViewBuilder
    private var addNewMatchViewTeams: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dupla 1")
                    .font(.title)
                    .foregroundStyle(Color.white)
                
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerOne)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerTwo)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
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
                    .foregroundStyle(Color.white)
                
                TextField("Nome do Jogador 1", text: $addNewMatchVM.playerThree)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField("Nome do Jogador 2", text: $addNewMatchVM.playerFour)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
            }
            .multilineTextAlignment(TextAlignment.trailing)
            .textFieldStyle(.roundedBorder)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 2)
                .stroke(Color.white, lineWidth: 2)
            
        )
        .padding(.horizontal, 10)
    }
    
}
