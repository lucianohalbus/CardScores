//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject private var authenticationVM = AuthenticationViewModel()
    @Binding var showLoginView: Bool
    @State var showCreateUserView: Bool = false
    @State private var showResetEmailAlert: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
        ScrollView {
            VStack {
                
                MainLogo()
                
                loginButonsView
                
                Spacer()
                
                Button(action: {
                    
                    loginVM.anonymousLogin()
                    
                }) {
                    Text("Login Anonymously")
                        .modifier(StandardButton())
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    guard !email.isEmpty else {
                        showResetEmailAlert = true
                        return
                    }
                    
                    loginVM.resetPassword(email: email)
                    
                }) {
                    VStack {
                        Text("Reset Password")
                            .font(.callout)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
                .alert(isPresented: $showResetEmailAlert) {
                    Alert(
                        title: Text("Wrong Email"),
                        message: Text("Enter a valid email address to reset the password"),
                        dismissButton: .default(Text("OK")))
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 5)
            .onChange(of: loginVM.userAuthenticated) { newValue in
                if newValue {
                    showLoginView = false
                }
            }
            .fullScreenCover(isPresented: $showCreateUserView, content: {
                CreateUserView(email: $email, password: $password, showCreatedUserView: $showCreateUserView)
                    .interactiveDismissDisabled()
                    .onDisappear(perform: {
                        loginVM.listen()
                        self.email = ""
                        self.password = ""
                    })
            })
        }
        .hideKeyboardWhenTappedAround()
    }
        .background(Color.cardColor)
        
    }
    
    var loginButonsView: some View {
        VStack {
            TextField(
                "e-mail: ",
                text: $email,
                prompt: Text("e-mail").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 5)
            
            SecureField(
                "Password: ",
                text: $password,
                prompt: Text("password").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            
            HStack(alignment: .top) {
                
                Spacer()
                Spacer()
                
                Button(action: {
                    Task {
                        do {
                            loginVM.login(email: email, password: password)
                        } 
                    }
                  
                }) {
                    VStack {
                        Text("Login")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    self.showCreateUserView = true
                    
                }) {
                    VStack {
                        Text("Create")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .bold()
                        
                        Text("Account")
                            .font(.title3)
                            .foregroundStyle(Color.cardColor)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .alert(isPresented: $loginVM.showAlert) {
                Alert(
                    title: Text(loginVM.alertMessage),
                    message: Text(loginVM.alertSuggestion),
                    dismissButton: .default(Text("OK")))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}
