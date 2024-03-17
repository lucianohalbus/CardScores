//Created by Halbus Development

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Card Scores")
                .font(.title)
                .fontWeight(.semibold)
            
            ZStack{
                
                Circle()
                    .stroke(Color.cardColor, lineWidth: 3)
                    .frame(width: 120, height: 120)
                
                Image("Logo")
                    .resizable()
                    .frame(width: 110, height: 110)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 100)
                
            }
            .padding()
            
            Group {
                
              
                
                VStack(spacing: 0) {
                    TextField("e-mail: ", text: $loginVM.email)
                        .modifier(LoginTextField())
                        .padding(.bottom, 5)
                    
                    SecureField("Password: ", text: $loginVM.password)
                        .modifier(LoginTextField())
                        .padding(.bottom, 20)
                    
                    HStack {
                        Spacer()
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
                        
                        Spacer()
                        
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
                        
                        Spacer()
                    }
                }
                .frame(height: 200)
                
            }
            
            
            Spacer()
            
            Button(action: {
                loginVM.anonymousLogin()
            }) {
                Text("Login Anonymously")
                    .modifier(StandardButton())
            }

            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(5)
        .onAppear(perform: {
            print("$$$$$$$$$$$")
            print(loginVM.userId)
            print("$$$$$$$$$$$")
        })
    }
}
