//Created by Halbus Development

import SwiftUI

struct AddTeamPlayerTextField: View {
    @Binding var player: String
    var textFieldAlign: TextAlignment
    var placeholder: String
    var placerHolderAlign: Alignment
    
    var body: some View {
        ZStack(alignment: placerHolderAlign) {
            Text(placeholder)
                .font(.callout)
                .foregroundStyle(player.isEmpty ? Color.white.opacity(0.5) : Color.clear)
            
            TextField("", text: $player)
                .foregroundColor(Color.white)
                .frame(height: 40)
                .cornerRadius(5)
                .font(.callout)
                .minimumScaleFactor(0.4)
                .multilineTextAlignment(textFieldAlign)
        }
        .padding(.horizontal, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}

#Preview {
    AddTeamPlayerTextField(
        player: .constant(""), 
        textFieldAlign: .trailing, 
        placeholder: "",
        placerHolderAlign: .leading
    )
}
