//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var loginVM = LoginViewModel()
    @StateObject var authenticationVM = AuthenticationViewModel()
    @StateObject var userRepo = UserRepository()
    @StateObject var addNewBuracoVM = AddNewBuracoFBViewModel()
    
    @Binding var showLoginView: Bool
    
    @State private var showCreateAccount: Bool = false
    @State private var showDeleteButtonAlert: Bool = false
    @State var isButtonIniciarClicked: Bool = false
    
    @State var teamOne: [String] = []
    @State var teamTwo: [String] = []
    @State var shouldCleanTeams: Bool = false
    @State var setTeamOneColor: Bool = false
    @State var setTeamTwoColor: Bool = false
    
    @State var cleanButtonColor: Color = Color.black

    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack {
                
                MiniLogo()
                
                ScrollView {
                    
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("Bem-Vindo: \(userRepo.user.userName)")
                            .padding(.bottom, 10)
                        
                        
                        Text("Informações da Conta")
                            .foregroundStyle(.yellow)
                        Text("Email: \(userRepo.user.userEmail)")
                        Text("Id: \(userRepo.user.userId ?? "")")
                        Text("Conta criada em: \(userRepo.user.createdTime.formatted(date: .abbreviated, time: .omitted))")
                        
                    }
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    
                    Divider()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                    
                    listOfFriends
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                           
                        } label: {
                            Text("Iniciar")
                        }
                        .font(.title3)
                        .fontWeight(.bold)
                        .tint(.green.opacity(0.9))
                        .controlSize(.regular)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            shouldCleanTeams = true
                            cleanButtonColor = Color.white
                            print("teamOne: \(teamOne)")
                            print("teamTwo: \(teamTwo)")
                            print("shouldCleanTeams: \(shouldCleanTeams)")
                        } label: {
                            Text("Limpar")
                        }
                        .font(.title3)
                        .fontWeight(.bold)
                        .tint(.green.opacity(0.9))
                        .controlSize(.regular)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                    }
                    
                    logoutButton
                    deleteButton
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
                
            }
            .onChange(of: shouldCleanTeams) { newValue in
                if newValue {
                    teamOne.removeAll()
                    teamTwo.removeAll()
                    shouldCleanTeams = false
                }
                
                print("teamOne: \(teamOne)")
                print("teamTwo: \(teamTwo)")
                print("shouldCleanTeams: \(shouldCleanTeams)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                userRepo.getUser()
            }
            .alert(isPresented:$showDeleteButtonAlert) {
                Alert(
                    title: Text("Warning!"),
                    message: Text("This action will permanently delete all your data, including your saved match data"),
                    primaryButton: .destructive(Text("Continue")) {
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
        .background(Color.cardColor)
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
                    Text("Logout")
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
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var deleteButton: some View {
        VStack {
            
            Button {
                self.showDeleteButtonAlert = true
                
            } label: {
                VStack (){
                    Text("DELETE ACCOUNT")
                        .font(.title3)
                        .fontWeight(.bold)
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
        }
        .padding(.horizontal)
    }
    
    var listOfFriends: some View {
        VStack(alignment: .center) {
            
            Text("Lista de Amigos")
                .foregroundStyle(Color.yellow)
                .font(.callout)
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.user.friendsName, id: \.self) { friend in
                    
                    FriendGridItem(friend: friend, setTeamOneColor: $setTeamOneColor, setTeamTwoColor: $setTeamTwoColor, cleanButtonColor: $cleanButtonColor) {
                        if teamOne.count < 2 {
                            teamOne.append(friend)
                            setTeamOneColor = true
                            setTeamTwoColor = false
                            cleanButtonColor = Color.black
                        } else if teamOne.count >= 2 && teamTwo.count < 2 {
                            teamTwo.append(friend)
                            setTeamOneColor = false
                            setTeamTwoColor = true
                        } else if teamOne.count == 2 && teamTwo.count == 2 {
                            setTeamOneColor = false
                            setTeamTwoColor = false
                        }
                        
                        print("teamOne: \(teamOne)")
                        print("teamTwo: \(teamTwo)")
                        print("shouldCleanTeams: \(shouldCleanTeams)")
                        print("setTeamOneColor: \(setTeamOneColor)")
                        print("setTeamTwoColor: \(setTeamTwoColor)")
                        
                        
                    } actionRemove: {
 
                    }
                } 
            }
        }
        .padding(.horizontal)
    }
}

struct FriendGridItem: View {
    var friend: String
    @Binding var setTeamOneColor: Bool
    @Binding var setTeamTwoColor: Bool
    @Binding var cleanButtonColor: Color
    
    @State var backColor: Color = Color.white
    var actionAppend: () -> Void
    var actionRemove: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                actionAppend()
                actionRemove()
                
                if setTeamOneColor {
                    backColor = Color.yellow
                } else if setTeamTwoColor {
                    backColor = Color.red
                }
                
                print("cleanButtonColor: \(cleanButtonColor)")
            } label: {
                ZStack {
                    Text(friend)
                }
                
            }
            .modifier(FriendsButton(backColor: backColor))
        }
        .padding(.horizontal)
        .onChange(of: cleanButtonColor) { newValue in
            if newValue == Color.white {
                self.backColor = newValue
            }
        }
       
    }
}
