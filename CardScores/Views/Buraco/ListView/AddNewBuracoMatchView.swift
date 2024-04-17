//Created by Halbus Development

import SwiftUI

struct AddNewBuracoMatchView: View {
    @EnvironmentObject var buracoMatchVM: BuracoMatchViewModel
    @StateObject var userRepo = UserRepository()
    @Environment(\.dismiss) private var dismiss
    
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
    // @State var path = [String]()
    
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
                        
                        addNewMatchViewHeader
                        
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
                        
                            NavigationLink(value: MainNavigation.child(BuracoFBViewModel(matchFB: buracoMatchVM.createdItem))) {
                                Text("Iniciar")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .tint(.green.opacity(0.9))
                                    .controlSize(.regular)
                                    .buttonStyle(.borderedProminent)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                buracoMatchVM.add()
                            })
                            .navigationDestination(for: MainNavigation.self) { view in
                                switch view {
                                case .child:
                                    BuracoMatchView(matchFB: BuracoFBViewModel(
                                        matchFB: MatchFB(
                                            id: buracoMatchVM.createdItem.id,
                                            scoreToWin: buracoMatchVM.createdItem.scoreToWin,
                                            playerOne: buracoMatchVM.createdItem.playerOne,
                                            playerTwo: buracoMatchVM.createdItem.playerTwo,
                                            playerThree: buracoMatchVM.createdItem.playerThree,
                                            playerFour: buracoMatchVM.createdItem.playerFour,
                                            finalScoreOne: buracoMatchVM.createdItem.finalScoreOne,
                                            finalScoreTwo: buracoMatchVM.createdItem.finalScoreTwo,
                                            friendsId: buracoMatchVM.createdItem.friendsId,
                                            myDate: buracoMatchVM.createdItem.myDate,
                                            registeredUser: buracoMatchVM.createdItem.registeredUser,
                                            docId: buracoMatchVM.createdItem.docId,
                                            gameOver: buracoMatchVM.createdItem.gameOver
                                        )
                                    ))
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .onAppear {
                        userRepo.getUser()
                    }
                    .onChange(of: shouldCleanTeams) { newValue in
                        if newValue {
                            shouldCleanTeams = false
                        }
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
    private var addNewMatchViewHeader: some View {
        VStack(spacing: 0) {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.headline)
                .foregroundStyle(Color.white)
            TextField("Digite a pontuação", text: $buracoMatchVM.scoreToWin)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(TextAlignment.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
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
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.listOfFriends, id: \.self) { friend in
                    
                    FriendGridItem(friend: friend, setSelectedButtonColor: $setSelectedButtonColor, cleanButtonColor: $cleanButtonColor) {
                        
                        if buracoMatchVM.playerOne.isEmpty {
                            placeholderOne = friend
                            buracoMatchVM.playerOne = friend
                            setSelectedButtonColor = true
                            cleanButtonColor = Color.black
                        } else if buracoMatchVM.playerTwo.isEmpty {
                            placeholderTwo = friend
                            buracoMatchVM.playerTwo = friend
                            setSelectedButtonColor = true
                        } else if buracoMatchVM.playerThree.isEmpty {
                            placeholderThree = friend
                            buracoMatchVM.playerThree = friend
                            setSelectedButtonColor = true
                        } else if buracoMatchVM.playerFour.isEmpty {
                            placeholderFour = friend
                            buracoMatchVM.playerFour = friend
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
