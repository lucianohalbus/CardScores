//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var loginVM = LoginViewModel()
    @StateObject private var authenticationVM = AuthenticationViewModel()
    @Binding var showLoginView: Bool
    @State private var showCreateAccount: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
           
            MiniLogo()
                .padding(.bottom, 10)
            
            Divider()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background(Color.textFieldBorderColor)
            
            Spacer()
            
            logoutButton

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
    
    var logoutButton: some View {
        VStack {
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
                VStack (){
                    Text("Logout")
                        .font(.title3)
                        .foregroundStyle(Color.cardColor)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        
                }
                .padding(.top, 10)
            }
        }
    }
}

