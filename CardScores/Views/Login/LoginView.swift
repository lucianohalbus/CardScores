//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                MainLogo()
            }
            .padding(.bottom, 50)
            
            Group {
                if Auth.auth().currentUser?.uid != nil {
                    
                    Button(action: {
                        loginVM.signOut()
                    }) {
                        VStack (){
                            ZStack {
                                Image(systemName: "tray.and.arrow.up.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.cardColor, Color.cardColor)
                                
                            }
                            
                            Text("Logout")
                                .font(.caption)
                                .foregroundStyle(Color.cardColor)
                                .bold()
                        }
                    }
                    
                } else {
                    
                    VStack(spacing: 0) {
                        TextField("e-mail: ", text: $loginVM.email)
                            .modifier(LoginTextField())
                            .padding(.bottom, 5)
                        
                        SecureField("Password: ", text: $loginVM.password)
                            .modifier(LoginTextField())
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            loginVM.login(email: loginVM.email, password: loginVM.password)
                        }) {
                            VStack (){
                                ZStack {
                                    Image(systemName: "tray.and.arrow.down.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color.cardColor, Color.cardColor)
                                }
                                
                                Text("Enter")
                                    .font(.caption)
                                    .foregroundStyle(Color.cardColor)
                                    .bold()
                            }
                        }
                        .padding(.bottom, 50)
                        
                        Button(action: {
                            loginVM.anonymousLogin()
                        }) {
                            Text("Login Anonymously")
                                .modifier(StandardButton())
                        }
                    }
                    .frame(height: 200)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(5)
    }
}
