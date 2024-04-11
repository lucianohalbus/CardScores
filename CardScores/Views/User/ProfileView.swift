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
    
    var body: some View {
        ZStack {
            VStack {
                
                MiniLogo()
            
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("Nome: \(userRepo.user.userName)")
                        Text("Email: \(userRepo.user.userEmail)")
                        Text("Id: \(userRepo.user.userId ?? "")")
                        Text("Conta criada em: \(userRepo.user.createdTime.formatted(date: .abbreviated, time: .omitted))")
                    }
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)

                    logoutButton
                    
                    deleteButton
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
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
    }
}

#Preview {
    ProfileView(
        loginVM: LoginViewModel(),
        showLoginView: .constant(false)
    )
}
