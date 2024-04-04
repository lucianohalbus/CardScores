//Created by Halbus Development

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var authenticationVM = AuthenticationViewModel()
    
    var body: some View {
        VStack {
 
            TextField("e-mail: ", text: $authenticationVM.email)
                .modifier(LoginTextField())
                .padding(.bottom, 5)
            
            SecureField("Password: ", text: $authenticationVM.password)
                .modifier(LoginTextField())
                .padding(.bottom, 20)
            
            
            Button(action: {
                Task {
                    try await authenticationVM.signUp()
                }
                
            }) {
                VStack (){
                    Text("Login")
                        .font(.caption)
                        .foregroundStyle(Color.cardColor)
                        .fontWeight(.bold)
                }
            }
            
            
        }
    }
}
