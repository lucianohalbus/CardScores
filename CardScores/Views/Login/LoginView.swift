//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @StateObject private var authenticationVM = AuthenticationViewModel()
    @Binding var showLoginView: Bool
    @State private var showCreateAccount: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            MainLogo()
            
            VStack(spacing: 0) {
                
                loginButonsView
                
                Button(action: {
                    
                    loginVM.anonymousLogin()
                    showLoginView = false
                }) {
                    Text("Login Anonymously")
                        .modifier(StandardButton())
                }
                .padding(.bottom, 10)
                
                Button(action: {
                    
                }) {
                    VStack(spacing: -5){
                        Text("Reset Password")
                            .font(.callout)
                            .foregroundStyle(Color.cardColor)
                            .bold()
                    }
                }
                
                Spacer()
                
            }
            .frame(height: 200)
            .padding(.top, 100)
            .onDisappear {
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(5)
        .alert(isPresented: $loginVM.showAlertError) {
            Alert(
                title: Text(loginVM.errorString),
                message: Text(loginVM.errorSuggestion),
                dismissButton: .default(Text("OK")))
        }
    }
    
    var loginButonsView: some View {
        VStack {
            TextField("e-mail: ", text: $loginVM.email)
                .font(.title3)
                .modifier(LoginTextField())
                .padding(5)
                .padding(.bottom, 5)
            
            SecureField("Password: ", text: $loginVM.password)
                .font(.title3)
                .modifier(LoginTextField())
                .padding(5)
                .padding(.bottom, 20)
            
            HStack {
                Spacer()
                
                Button(action: {
                    if !loginVM.email.isEmpty, !loginVM.password.isEmpty {
                        loginVM.login(email: loginVM.email, password: loginVM.password)
                        showLoginView = false
                    }
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
