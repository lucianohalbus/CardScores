//Created by Halbus Development

import SwiftUI

struct AddFriend: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var userRepo = UserRepository()
    @State var friendName: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Nome: ", text: $friendName)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.textViewBackgroundColor)
                    .cornerRadius(10)
                    .font(.title)
                    .multilineTextAlignment(TextAlignment.leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .padding(.bottom, 10)
                
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
                        if !friendName.isEmpty {
                            userRepo.addFriend(friend: friendName)
                        }
                        
                        dismiss()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .tint(.green.opacity(0.9))
                    .controlSize(.regular)
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
    }
}

#Preview {
    AddFriend(userRepo: UserRepository(), friendName: "")
}
