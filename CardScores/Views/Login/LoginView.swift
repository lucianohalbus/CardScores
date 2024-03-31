//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @StateObject private var authenticationVM = AuthenticationViewModel()
    @Binding var tabSelection: Int
    @Binding var isUserAuthenticated: Bool
    @State private var showCreateAccount: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
           
            MainLogo()

            if isUserAuthenticated {
                logoutButton

            } else {
                VStack(spacing: 0) {
                   
                    loginButonsView
                    
                    Button(action: {
                        loginVM.anonymousLogin()
                    }) {
                        Text("Login Anonymously")
                            .modifier(StandardButton())
                    }
                }
                .frame(height: 200)
                .padding(.top, 100)
            }
        
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(5)
    }
    
    var logoutButton: some View {
        VStack {
            Button(action: {
                Task {
                    do {
                        try authenticationVM.logOut()
                        isUserAuthenticated = false
                    } catch {
                        print(error)
                    }
                }
            }) {
                VStack (){
                    Text("Logout")
                        .font(.caption)
                        .foregroundStyle(Color.cardColor)
                        .bold()
                }
            }
        }
    }
    
    var loginButonsView: some View {
        VStack {
            TextField("e-mail: ", text: $loginVM.email)
                .font(.title3)
                .modifier(LoginTextField())
                .padding(.bottom, 5)
            
            SecureField("Password: ", text: $loginVM.password)
                .font(.title3)
                .modifier(LoginTextField())
                .padding(.bottom, 20)
            
            HStack {
                Spacer()
                
                Button(action: {
                    loginVM.login(email: loginVM.email, password: loginVM.password)
                }) {
                    VStack(spacing: -5){
                        Text("Login")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    VStack(spacing: -5){
                        Text("Reset")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                        Text("Password")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.showCreateAccount.toggle()
                }) {
                    VStack(spacing: -5){
                        Text("Create")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                        
                        Text("Account")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                    }
                }
                
                Spacer()
            }
        }
        .padding(.bottom, 30)
    }
}
