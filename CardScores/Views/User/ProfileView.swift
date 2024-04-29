//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var userRepo: UserRepository
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authenticationVM = AuthenticationViewModel()
    @StateObject var buracoMatchVM = BuracoMatchViewModel()
    
    @Binding var showLoginView: Bool
    @Binding var path: [MainNavigation]
    @State var isUserLinked: Bool = false
    
    @State var friendToRemove: String = ""
    @State private var showDeleteButtonAlert: Bool = false
    @State var isButtonIniciarClicked: Bool = false
    @State var showAddFriends: Bool = false
    @State var showSharingMatchView: Bool = false
    @State var showRemoveFriendAlert: Bool = false
    @State var isUserAnonymous: Bool = false
    @State private var buttonText  = ""
    private let pasteboard = UIPasteboard.general
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    
                    MiniLogo()
                    
                    VStack(alignment: .leading) {
                        
                        playerInformations
                        
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .padding(.bottom, 10)
                        
                        listOfFriends
                        
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        
                        sharingButton
                        
                        if userRepo.isUserAnonymous {
                            linkAccountButton
                        }
                        logoutButton
                        deleteButton
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onAppear {
                    userRepo.getUser()
                    buracoMatchVM.getMatches()
                }
                .sheet(isPresented: $showAddFriends, onDismiss: {
                    userRepo.getUser()
                }) {
                    AddFriend()
                        .presentationDetents([.medium])
                }
                .sheet(isPresented: $showSharingMatchView, onDismiss: {
                    self.showSharingMatchView = false
                }) {
                    SharingMatchesView()
                        .presentationDetents([.medium])
                }
                .onChange(of: isUserLinked) { newValue in
                    if newValue {
                        userRepo.getUser()
                    }
                }
                .onChange(of: buttonText) { newValue in
                    if newValue.description == "Copied!" {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.buttonText = ""
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cardColor)
            .navigationTitle("")
        }
    }
    
    var playerInformations: some View {
        VStack(alignment: .leading) {
            Text("Bem-Vindo: \(userRepo.user.userName)")
                .padding(.bottom, 10)
            
            Text("Informações da Conta")
                .foregroundStyle(.yellow)
            Text("Email: \(userRepo.user.userEmail)")
            
            HStack {
                Text("ID: \(userRepo.user.userId?.description ?? "Usuário Anônimo")")
                    .contextMenu {
                        Button {
                            copyToClipboard()
                        } label: {
                            Text("")
                        }
                    }
                
                Button {
                    copyToClipboard()
                } label: {
                    Image(systemName: "doc.on.doc")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                    
                }
                
                Text(buttonText)
                    .font(.caption2)
                    .foregroundColor(.white)
                
            }
            Text("Conta criada em: \(userRepo.user.createdTime.formatted(date: .abbreviated, time: .omitted))")
            
            Text("Total de partidas salvas: \(buracoMatchVM.matchesVM.count)")
        }
        .font(.callout)
        .fontWeight(.semibold)
        .foregroundStyle(Color.white)
        .padding(.horizontal, 15)
    }
    
    var linkAccountButton: some View {
        VStack {
            
            Button {
                path.append(.anotherChild)
                
            } label: {
                VStack (){
                    Text("Criar Conta")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.cardColor)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                    
                }
                .padding(.top, 10)
            }
            .navigationDestination(for: MainNavigation.self) { view in
                switch view {
                case .anotherChild:
                    LinkAccountView(path: $path, isUserLinked: $isUserLinked)
                default:
                    EmptyView()
                }
                
            }
        }
        .padding(.bottom, 10)
    }
    
    var sharingButton: some View {
        VStack(alignment: .leading) {
            Button(action: {
                self.showSharingMatchView.toggle()
            }) {
                VStack {
                    Text("Compartilhar")
                        .font(.title3)
                        .foregroundStyle(Color.cardColor)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 30)
    }
    
    
    var logoutButton: some View {
        VStack(alignment: .leading) {
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
                VStack {
                    Text(userRepo.isUserAnonymous ? "Sair da Conta Anônima" : "Sair da conta")
                        .font(.title3)
                        .foregroundStyle(Color.cardColor)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 30)
    }
    
    var deleteButton: some View {
        VStack {
            
            Button {
                self.showDeleteButtonAlert = true
                
            } label: {
                VStack (){
                    Text(userRepo.isUserAnonymous ? "Apagar a Conta Anônima" : "Apagar Conta")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.textFieldBorderColor)
                        )
                        .background(.white)
                        .cornerRadius(10)
                    
                }
                .padding(.top, 10)
            }
            .alert(isPresented:$showDeleteButtonAlert) {
                Alert(
                    title: Text("Atenção!"),
                    message: Text("Essa ação irá deletar permanentemente todos os seus dados"),
                    primaryButton: .destructive(Text("Continuar")) {
                        Task {
                            do {
                                try await authenticationVM.deleteAccount()
                                showLoginView = true
                            } catch {
                                print(error)
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    var listOfFriends: some View {
        VStack(alignment: .center) {
            
            Text("Lista de Amigos")
                .font(.callout)
                .foregroundStyle(Color.yellow)
                .fontWeight(.bold)
            
            if userRepo.isUserAnonymous {
                Text("Somente usuários cadastrados")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.top, 20)
                Text("podem adicionar amigos.")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 20)
            } else {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(userRepo.listOfFriends, id: \.self) { friend in
                        Text(friend)
                            .font(.caption)
                            .padding(5)
                            .frame(width: 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.cardColor)
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray)
                            )
                            .onTapGesture {}.onLongPressGesture(minimumDuration: 0.2) {
                                showRemoveFriendAlert = true
                                self.friendToRemove = friend
                            }
                    }
                    .alert(isPresented:$showRemoveFriendAlert) {
                        Alert(
                            title: Text("Remove Friend"),
                            message: Text("Essa ação removerá esse nome da sua lista de amigos"),
                            primaryButton: .destructive(Text("Continuar")) {
                                Task {
                                    print("antes \(friendToRemove)")
                                    userRepo.removeFriend(friend: friendToRemove)
                                    userRepo.getUser()
                                    self.friendToRemove = ""
                                    print("depois \(friendToRemove)")
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding(.bottom, 10)
            }
            
            Button {
                showAddFriends.toggle()
                print(userRepo.isUserAnonymous)
            } label: {
                Text("Adicionar Amigos")
                    .font(.callout)
                    .padding(5)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.black)
                    .background(Color.mainButtonColor)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray)
                    )
            }
            .disabled(userRepo.isUserAnonymous)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
    
    func copyToClipboard() {
        let text: String = userRepo.user.userId?.description ?? "Usuário Anônimo"
        pasteboard.string = text
        
        self.buttonText = ""
        // self.text = "" // clear the text after copy
        DispatchQueue.main.async {
            self.buttonText = "Copied!"
        }
    }
    
}

//#Preview {
//    ProfileView(
//        loginVM: LoginViewModel(),
//        authenticationVM: AuthenticationViewModel(),
//        buracoMatchVM: BuracoMatchViewModel(),
//        showLoginView: .constant(false),
//        path: .constant([.anotherChild]),
//        friendToRemove: "",
//        isButtonIniciarClicked: false,
//        showAddFriends: false,
//        showRemoveFriendAlert: false,
//        isUserAnonymous: false,
//        gridItems: [
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible())
//        ]
//    )
//}
