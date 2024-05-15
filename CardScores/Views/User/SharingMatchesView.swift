//Created by Halbus Development

import SwiftUI

struct SharingMatchesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var buracoMatchVM = BuracoMatchViewModel()
    @State var friendId: String = ""
    var userName: String
    
    var body: some View {
        ZStack {
            VStack {
                TextField("ID: ", text: $friendId)
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
                        if !friendId.isEmpty {
                            buracoMatchVM.shareMatches(friendsId: friendId, userName: userName)
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
    SharingMatchesView(userName: "")
}
