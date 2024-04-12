//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authenticationVM = AuthenticationViewModel()
    @StateObject var userRepo = UserRepository()
    @Binding var showLoginView: Bool
    @State private var showCreateAccount: Bool = false
    @State private var showDeleteButtonAlert: Bool = false
    @State private var isFriendSelected: Bool = false
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                
                MiniLogo()
            
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("Bem-Vindo: \(userRepo.user.userName)")
                            .padding(.bottom, 10)
                        
                        
                        Text("Informações da Conta")
                            .foregroundStyle(.yellow)
                        Text("Email: \(userRepo.user.userEmail)")
                        Text("Id: \(userRepo.user.userId ?? "")")
                        Text("Conta criada em: \(userRepo.user.createdTime.formatted(date: .abbreviated, time: .omitted))")

                    }
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    
                    Divider()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                    
                    listOfFriends
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Iniciar")
                        }
                        .font(.title3)
                        .fontWeight(.bold)
                        .tint(.green.opacity(0.9))
                        .controlSize(.regular)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                userRepo.getUser()
            }
            .alert(isPresented:$showDeleteButtonAlert) {
                Alert(
                    title: Text("Warning!"),
                    message: Text("This action will permanently delete all your data, including your saved match data"),
                    primaryButton: .destructive(Text("Continue")) {
                        Task {
                            do {
                                try await authenticationVM.deleteAccount()
                                showLoginView = true
                            } catch {
                                print(error)
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .background(Color.cardColor)
    }
    
    var logoutButton: some View {
        VStack(alignment: .leading) {
            Button(action: {
                Task {
                    do {
                        try authenticationVM.logOut()
                        showLoginView = true
                    } catch {
                        print(error)
                    }
                }
            }) {
                VStack {
                    Text("Logout")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.cardColor)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var deleteButton: some View {
        VStack {
            
            Button {
                self.showDeleteButtonAlert = true
                
            } label: {
                VStack (){
                    Text("DELETE ACCOUNT")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                    
                }
                .padding(.top, 10)
            }
        }
        .padding(.horizontal)
    }
    
    var listOfFriends: some View {
        VStack(alignment: .center) {
            
            Text("Lista de Amigos")
                .foregroundStyle(Color.yellow)
                .font(.callout)
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.user.friendsName, id: \.self) { friend in
                    FriendGridItem(friend: friend)
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct FriendGridItem: View {
    @State private var isFriendSelected: Bool = false
    @StateObject var addNewBuracoVM = AddNewBuracoFBViewModel()
    var friend: String
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                self.isFriendSelected.toggle()
                print(isFriendSelected)
                
                if isFriendSelected {
                    addNewBuracoVM.playersOfTheMatch.append(friend)
                } else {
                    addNewBuracoVM.playersOfTheMatch.removeAll { $0 == friend }
                }
                
                print(addNewBuracoVM.playersOfTheMatch)
                
            } label: {
                ZStack {
                    
                    Text(friend)
                    
                    Image(systemName: isFriendSelected ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .cornerRadius(2)
                        .offset(x: 38, y: -18)
                }
                
            }
            .modifier(FriendsButton())
        }
        .padding(.horizontal)
    }
}
