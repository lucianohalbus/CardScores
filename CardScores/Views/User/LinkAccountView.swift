//Created by Halbus Development

import SwiftUI

struct LinkAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userRepo: UserRepository
    @StateObject var loginVM = LoginViewModel()
    @State var userName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var path: [MainNavigation]
    @Binding var isUserLinked: Bool
    
    var body: some View {
        ZStack {
            VStack {
                MiniLogo()
                
                Text("Registrar Novo Usuário")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding(.vertical, 10 )
                
                linkAccountFields
                
                linkAccountButtons

                Spacer()
            }
            .onChange(of: userRepo.isUserCreated) { newValue in
                if newValue {
                    path.removeAll()
                    self.userName = ""
                    self.email = ""
                    self.password = ""
                    
                    self.isUserLinked.toggle()
                }
            }
            .alert(isPresented: $userRepo.showAlert) {
                Alert(
                    title: Text(userRepo.alertMessage),
                    message: Text(userRepo.alertSuggestion),
                    dismissButton: .default(Text("OK")))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
    }
    
    var linkAccountFields: some View {
        VStack {
            TextField(
                "Name",
                text: $userName,
                prompt: Text("Nome: ").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 5)
            
            TextField(
                "e-mail: ",
                text: $email,
                prompt: Text("E-mail: ").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 5)
            
            SecureField(
                "senha",
                text: $password,
                prompt: Text("Senha: ").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 20)
            
        }
    }
    
    var linkAccountButtons: some View {
        HStack {
            Spacer()
            
            Button("Cancelar", role: .destructive) {
                dismiss()
            }
            .font(.title3)
            .fontWeight(.bold)
            .tint(.green.opacity(0.9))
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Registrar") {
                userRepo.linkAnonymousUser(email: email, password: password, userName: userName)
            }
            .font(.title3)
            .fontWeight(.bold)
            .tint(.green.opacity(0.9))
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
    
}
