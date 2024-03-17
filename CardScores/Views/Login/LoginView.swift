//Created by Halbus Development

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Card Scores")
                .font(.title)
                .fontWeight(.semibold)
//                .foregroundColor(Color("Button"))
            
            ZStack{
                
                Circle()
                    .stroke(Color.cardColor, lineWidth: 3)
                    .frame(width: 150, height: 150)
                
                Image(systemName: "list.bullet.clipboard")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 100)
                
            }
            .padding()
            
            VStack () {
                TextField("e-mail", text: $loginVM.email)
                    .modifier(LoginTextField())
                    .padding(.bottom, 5)
                SecureField("Password", text: $loginVM.password)
                    .modifier(LoginTextField())
                
                HStack {
                    Spacer()
                    Button(action: {
                        loginVM.login(email: loginVM.email, password: loginVM.password)
                        
                        if loginVM.isSignedIn {
                            //      return viewRouter.currentPage = .newmatchpicker
                        }
                    }) {
                        VStack (){
                            ZStack {
                                Image(systemName: "tray.and.arrow.down.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Text("Enter")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        loginVM.unbind()
                        
                        if loginVM.isSignedIn {
                            //      return viewRouter.currentPage = .newmatchpicker
                        }
                    }) {
                        VStack (){
                            ZStack {
                                Image(systemName: "tray.and.arrow.down.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            
                            Text("Logout")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 2)
                    .stroke(Color.cardColor, lineWidth: 2)
            )

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
