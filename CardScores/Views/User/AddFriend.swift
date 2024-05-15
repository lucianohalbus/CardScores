//Created by Halbus Development

import SwiftUI

struct AddFriend: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var userVM = UserViewModel()
    @State var friendId: String = ""
    @Binding var currentUser: ProfileModel
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Nome: ", text: $friendId)
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
                            Task {
                                await userVM.addFriends(friendId: friendId, currentUser: currentUser)
                            }
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
    AddFriend(
        friendId: "",
        currentUser: .constant(
            ProfileModel(
                userId: "",
                userName: "",
                userEmail: "",
                friends: [
                    FriendsModel(
                        friendId: "",
                        friendEmail: "",
                        friendName: ""
                    )
                ],
                createdTime: Date(),
                numberOfWins: 0,
                averageScores: 0,
                numberOfMatches: 0,
                isUserAnonymous: false
            )
        )
    )
}
