//Created by Halbus Development

import SwiftUI

struct BuracoPresencialStartView: View {
    @EnvironmentObject var buracoMatchVM: BuracoMatchViewModel
    @StateObject var userVM = UserViewModel()
    
    @State var userProfile: ProfileModel?
    @State var teamOne: [String] = []
    @State var teamTwo: [String] = []
    @State var shouldCleanTeams: Bool = false
    @State var setSelectedButtonColor: Bool = false
    @State var cleanButtonColor: Color = Color.black
    
    @State var placeholderOne: String = "Nome do Jogador 1"
    @State var placeholderTwo: String = "Nome do Jogador 2"
    @State var placeholderThree: String = "Nome do Jogador 3"
    @State var placeholderFour: String = "Nome do Jogador 4"
    @State var isDocCreated: Bool = false
    @State var textFieldAux: String = ""
    
    @State var selectedMatch: BuracoFBViewModel = BuracoFBViewModel(matchFB: MatchFB(scoreToWin: "", playerOne: "", playerTwo: "", playerThree: "", playerFour: "", finalScoreOne: "", finalScoreTwo: "", friendsId: [""], myDate: Date(), registeredUser: false, docId: "", gameOver: false))
    
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
                        
                        addNewMatchViewTeams
                        
                        footNotes
                        
                        addedFriends
                        
                        HStack {
                            
                            Spacer()
                            
                            Button("Limpar", role: .destructive) {
                                shouldCleanTeams = true
                                cleanButtonColor = Color.white
                                placeholderOne = "Nome do Jogador 1"
                                buracoMatchVM.playerOne = ""
                                placeholderTwo = "Nome do Jogador 2"
                                buracoMatchVM.playerTwo = ""
                                placeholderThree = "Nome do Jogador 3"
                                buracoMatchVM.playerThree = ""
                                placeholderFour = "Nome do Jogador 4"
                                buracoMatchVM.playerFour = ""
                                setSelectedButtonColor = false
                                cleanButtonColor = Color.white
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .tint(.green.opacity(0.9))
                            .controlSize(.regular)
                            .buttonStyle(.borderedProminent)
                            
                            Spacer()
                            
                            Button("Iniciar") {
                                buracoMatchVM.add()
                            }
                            .font(.title3)
                            .fontWeight(.bold)
                            .tint(.green.opacity(0.9))
                            .controlSize(.regular)
                            .buttonStyle(.borderedProminent)
                            .navigationDestination(for: MainNavigation.self) { view in
                                switch view {
                                case .child:
                                    BuracoMatchView(matchFB: BuracoFBViewModel(
                                        matchFB: buracoMatchVM.createdItem))
                                default:
                                    EmptyView()
                                }
                                
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .onChange(of: buracoMatchVM.addNewSaved) { newValue in
                        if newValue {
                            path.append(.child(selectedMatch))
                        }
                    }
                    .onAppear {
                        Task {
                            self.userProfile = try await userVM.getUser()
                        }
                    }
                    .onChange(of: shouldCleanTeams) { newValue in
                        if newValue {
                            shouldCleanTeams = false
                        }
                    }
                    .alert(isPresented: $buracoMatchVM.showAlert) {
                        Alert(
                            title: Text(buracoMatchVM.alertMessage),
                            message: Text(buracoMatchVM.alertSuggestion),
                            dismissButton: .default(Text("OK")) {
                                self.buracoMatchVM.showAlert = false
                            }
                        )
                    }
                }
                .onDisappear {
                    shouldCleanTeams = true
                    cleanButtonColor = Color.white
                    placeholderOne = "Nome do Jogador 1"
                    buracoMatchVM.playerOne = ""
                    placeholderTwo = "Nome do Jogador 2"
                    buracoMatchVM.playerTwo = ""
                    placeholderThree = "Nome do Jogador 3"
                    buracoMatchVM.playerThree = ""
                    placeholderFour = "Nome do Jogador 4"
                    buracoMatchVM.playerFour = ""
                    setSelectedButtonColor = false
                    cleanButtonColor = Color.white
                    buracoMatchVM.addNewSaved = false
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
                
                TextField(placeholderOne, text: $buracoMatchVM.playerOne)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField(placeholderTwo, text: $buracoMatchVM.playerTwo)
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
                
                TextField(placeholderThree, text: $buracoMatchVM.playerThree)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField(placeholderFour, text: $buracoMatchVM.playerFour)
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
                        
                        FriendGridItem(friend: friend.friendName, setSelectedButtonColor: $setSelectedButtonColor, cleanButtonColor: $cleanButtonColor) {
                            
                            if buracoMatchVM.playerOne.isEmpty {
                                placeholderOne = friend.friendName
                                buracoMatchVM.playerOne = friend.friendName
                                setSelectedButtonColor = true
                                cleanButtonColor = Color.black
                            } else if buracoMatchVM.playerTwo.isEmpty {
                                placeholderTwo = friend.friendName
                                buracoMatchVM.playerTwo = friend.friendName
                                setSelectedButtonColor = true
                            } else if buracoMatchVM.playerThree.isEmpty {
                                placeholderThree = friend.friendName
                                buracoMatchVM.playerThree = friend.friendName
                                setSelectedButtonColor = true
                            } else if buracoMatchVM.playerFour.isEmpty {
                                placeholderFour = friend.friendName
                                buracoMatchVM.playerFour = friend.friendName
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
            Text("Preencha ou selecione os nomes das duplas.")
            Text("No Profile você pode adicionar novos amigos à lista.")
        }
        .font(.caption)
        .foregroundStyle(Color.white)
        .padding(.bottom, 20)
    }
    
}
