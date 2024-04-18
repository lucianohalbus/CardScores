//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authenticationVM = AuthenticationViewModel()
    @StateObject var userRepo = UserRepository()
    
    @Binding var showLoginView: Bool
    
    @State var friendToRemove: String = ""
    @State private var showDeleteButtonAlert: Bool = false
    @State var isButtonIniciarClicked: Bool = false
    @State var showAddFriends: Bool = false
    @State var showRemoveFriendAlert: Bool = false
    
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                
                MiniLogo()
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("Bem-Vindo: \(userRepo.user.userName)")
                                .padding(.bottom, 10)
                            
                            Text("Informações da Conta")
                                .foregroundStyle(.yellow)
                            Text("Email: \(userRepo.user.userEmail)")
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
                        
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                        
                        
                        HStack {
                            Spacer()
                            logoutButton
                            Spacer()
                            deleteButton
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                userRepo.getUser()
            }
            .sheet(isPresented: $showAddFriends, onDismiss: {
                userRepo.getUser()
            }) {
                AddFriend()
                    .presentationDetents([.medium])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Text("Sair    ")
                        .font(.title3)
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
                    Text("Apagar a Conta")
                        .font(.title3)
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
            .alert(isPresented:$showDeleteButtonAlert) {
                Alert(
                    title: Text("Atenção!"),
                    message: Text("Essa ação irá deletar permanentemente todos os seus dados"),
                    primaryButton: .destructive(Text("Continuar")) {
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
        .padding(.horizontal)
    }
    
    var listOfFriends: some View {
        VStack(alignment: .center) {
            
            Text("Lista de Amigos")
                .font(.callout)
                .foregroundStyle(Color.yellow)
                .fontWeight(.bold)
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.listOfFriends, id: \.self) { friend in
                    Text(friend)
                        .font(.caption)
                        .padding(5)
                        .frame(width: 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.cardColor)
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray)
                        )
                        .onTapGesture {}.onLongPressGesture(minimumDuration: 0.2) {
                            showRemoveFriendAlert = true
                            self.friendToRemove = friend
                        }
                }
                .alert(isPresented:$showRemoveFriendAlert) {
                    Alert(
                        title: Text("Remove Friend"),
                        message: Text("Essa ação removerá esse nome da sua lista de amigos"),
                        primaryButton: .destructive(Text("Continuar")) {
                            Task {
                                print("antes \(friendToRemove)")
                                userRepo.removeFriend(friend: friendToRemove)
                                userRepo.getUser()
                                self.friendToRemove = ""
                                print("depois \(friendToRemove)")
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding(.bottom, 10)
            
            Button {
                showAddFriends.toggle()
            } label: {
                Text("Adicionar Amigos")
                    .font(.callout)
                    .padding(5)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.black)
                    .background(Color.mainButtonColor)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray)
                    )
            }
        }
        .padding(.horizontal)
    }
}
