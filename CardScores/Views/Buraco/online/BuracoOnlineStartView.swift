//Created by Halbus Development

import SwiftUI

struct BuracoOnlineStartView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @StateObject var userVM = UserViewModel()
    @State var shouldCleanTeams: Bool = false
    @State var setSelectedButtonColor: Bool = false
    @State var cleanButtonColor: Color = Color.black
    @State var userProfile: ProfileModel?
    
    @Binding var path: [MainNavigation]
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack {
                        
                        MiniLogo()
                        
                        addNewMatchViewTeams
                        
                        footNotes
                        
                        addedFriends
                        
                        HStack {
                            
                            Spacer()
                            
                            Button("Limpar", role: .destructive) {
                                
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .tint(.green.opacity(0.9))
                            .controlSize(.regular)
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                            
                            Button("Iniciar") {
                                cardsVM.preparingDecks()
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .tint(.green.opacity(0.9))
                            .controlSize(.regular)
                            .buttonStyle(.borderedProminent)

                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .onAppear {
                        Task {
                            self.userProfile = try await userVM.getUser()
                        }
                    }
                    .onChange(of: cardsVM.createPlayers) { newValue in
                        Task {
                            try await cardsVM.addOnlinePlayers()
                        }
                    }
                    .onChange(of: cardsVM.showOnlineGame) { newValue in
                        if newValue {
                            path.append(.anotherChild)
                        }
                    }
                    .navigationDestination(for: MainNavigation.self) { view in
                        switch view {
                        case .anotherChild:
                            BuracoOnlineMatchView()
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cardColor)
        }
    }
    
    @ViewBuilder
    private var addNewMatchViewTeams: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dupla 1")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                
                TextField("Jogador 1", text: $cardsVM.onlinePlayerOne.playerName)
                    .disabled(true)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField("Jogador 2", text: $cardsVM.onlinePlayerTwo.playerName)
                    .disabled(true)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
            }
            .multilineTextAlignment(TextAlignment.leading)
            .textFieldStyle(.roundedBorder)
            
            VStack {
                Text("")
            }
            .frame(width: 30)
            
            VStack(alignment: .trailing) {
                Text("Dupla 2")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                
                TextField("Jogador 3", text: $cardsVM.onlinePlayerThree.playerName)
                    .disabled(true)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField("Jogador 4", text: $cardsVM.onlinePlayerFour.playerName)
                    .disabled(true)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
            }
            .multilineTextAlignment(TextAlignment.trailing)
            .textFieldStyle(.roundedBorder)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 2)
                .stroke(Color.white, lineWidth: 2)
            
        )
        .padding(.horizontal, 10)
    }
    
    var addedFriends: some View {
        VStack(alignment: .center) {
            
            Text("Lista de Amigos")
                .foregroundStyle(Color.yellow)
                .font(.callout)
                .fontWeight(.bold)
            
            if userVM.isUserAnonymous {
                Text("Crie uma conta para ter")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.top, 10)
                
                Text("acesso a lista de amigos.")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 20)
            } else {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(userVM.userProfile.friends, id: \.self) { friend in
                        
                        FriendGridItem(
                            friend: friend.friendName,
                            setSelectedButtonColor: $setSelectedButtonColor,
                            cleanButtonColor: $cleanButtonColor) {
                            
                            if cardsVM.onlinePlayerOne.playerName.isEmpty {
                                cardsVM.playerOne = friend
                                cardsVM.onlinePlayerOne.playerName = friend.friendName
                                setSelectedButtonColor = true
                                cleanButtonColor = Color.black
                            } else if cardsVM.onlinePlayerTwo.playerName.isEmpty {
                                cardsVM.playerTwo = friend
                                cardsVM.onlinePlayerTwo.playerName = friend.friendName
                                setSelectedButtonColor = true
                            } else if cardsVM.onlinePlayerThree.playerName.isEmpty {
                                cardsVM.playerThree = friend
                                cardsVM.onlinePlayerThree.playerName = friend.friendName
                                setSelectedButtonColor = true
                            } else if cardsVM.onlinePlayerFour.playerName.isEmpty {
                                cardsVM.playerFour = friend
                                cardsVM.onlinePlayerFour.playerName = friend.friendName
                                setSelectedButtonColor = true
                            } else {
                                setSelectedButtonColor = false
                            }
                        }
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 2)
                        .stroke(Color.white, lineWidth: 2)
                    
                )
            }
        }
        .padding(.horizontal)
    }
    
    var footNotes: some View {
        VStack {
            Text("Selecione os nomes das duplas.")
            Text("No Profile você pode adicionar novos amigos à lista.")
        }
        .font(.caption)
        .foregroundStyle(Color.white)
        .padding(.bottom, 20)
    }
    
}

#Preview {
    BuracoOnlineStartView(path: .constant([MainNavigation.child(BuracoFBViewModel(
        matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [], myDate: Date(), registeredUser: false, docId: "", gameOver: false)))])
    )
    .environmentObject(CardsViewModel())
}
