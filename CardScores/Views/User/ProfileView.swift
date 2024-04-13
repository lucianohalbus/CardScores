//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authenticationVM = AuthenticationViewModel()
    @StateObject var userRepo = UserRepository()
    @StateObject var addNewBuracoVM = AddNewBuracoFBViewModel()
    
    @Binding var showLoginView: Bool
    
    @State private var showDeleteButtonAlert: Bool = false
    @State var isButtonIniciarClicked: Bool = false
    @State var showAddFriends: Bool = false

    var gridItems = [
        GridItem(.flexible()),
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

                    logoutButton
                    
                    deleteButton
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                userRepo.getUser()
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
            .sheet(isPresented: $showAddFriends, onDismiss: {
                userRepo.getUser()
            }) {
                AddFriend()
                    .presentationDetents([.medium])
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
                .font(.callout)
                .foregroundStyle(Color.yellow)
                .fontWeight(.bold)

            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.listOfFriends, id: \.self) { friend in
                    Text(friend)
                        .font(.caption)
                        .padding(5)
                        .frame(width: 85, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.cardColor)
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray)
                        )
                }
            }
            
            Button {
                showAddFriends.toggle()
            } label: {
                Text("Adicionar Amigos")
                    .font(.caption)
                    .padding(5)
                    .frame(width: 200, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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

struct AddFriend: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var userRepo = UserRepository()
    @State var friendName: String = ""
    
    var body: some View {
        VStack {
            TextField("Nome", text: $friendName)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .padding()
                .font(.title)
                .foregroundStyle(Color.cardColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.textFieldBorderColor)
                )
            
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
}
