//Created by Halbus Development

import SwiftUI

struct CreateUserView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var loginVM = LoginViewModel()
    @State var userName: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                MiniLogo()
                
                Text("Registrar Novo Usuário")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding(.vertical, 10 )
                
                createUserFields
                
                createUserButtons

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
    }
    
    var createUserFields: some View {
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
                text: $loginVM.email,
                prompt: Text("E-mail: ").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 5)
            
            TextField(
                "senha",
                text: $loginVM.password,
                prompt: Text("Senha: ").foregroundColor(Color.gray.opacity(0.5))
            )
            .font(.title3)
            .modifier(LoginTextField())
            .padding(.bottom, 20)
            
        }
    }
    
    var createUserButtons: some View {
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
                
                dismiss()
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

#Preview {
    CreateUserView()
}
