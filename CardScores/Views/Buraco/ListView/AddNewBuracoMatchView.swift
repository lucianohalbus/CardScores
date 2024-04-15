//Created by Halbus Development

import SwiftUI

struct AddNewBuracoMatchView: View {
    @StateObject private var addNewMatchVM = AddNewBuracoFBViewModel()
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
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        MiniLogo()
                        
                        addNewMatchViewHeader
                        
                        addNewMatchViewTeams
                        
                        addedFriends
                        
                        HStack {
                            
                            Spacer()
                            
                            Button("Limpar", role: .destructive) {
                                shouldCleanTeams = true
                                cleanButtonColor = Color.white
                                placeholderOne = "Nome do Jogador 1"
                                addNewMatchVM.playerOne = ""
                                placeholderTwo = "Nome do Jogador 2"
                                addNewMatchVM.playerTwo = ""
                                placeholderThree = "Nome do Jogador 3"
                                addNewMatchVM.playerThree = ""
                                placeholderFour = "Nome do Jogador 4"
                                addNewMatchVM.playerFour = ""
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
                                addNewMatchVM.add()
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
                        userRepo.getUser()
                    }
                    .onChange(of: shouldCleanTeams) { newValue in
                        if newValue {
                            shouldCleanTeams = false
                        }
                    }
                    .navigationDestination(isPresented: $isDocCreated) {
                        BuracoMatchView(matchFB: BuracoFBViewModel(matchFB: MatchFB(id: addNewMatchVM.createdItem.id, scoreToWin: addNewMatchVM.createdItem.scoreToWin, playerOne: addNewMatchVM.createdItem.playerOne, playerTwo: addNewMatchVM.createdItem.playerTwo, playerThree: addNewMatchVM.createdItem.playerThree, playerFour: addNewMatchVM.createdItem.playerFour, finalScoreOne: addNewMatchVM.createdItem.finalScoreOne, finalScoreTwo: addNewMatchVM.createdItem.finalScoreTwo, friendsId: addNewMatchVM.createdItem.friendsId, myDate: addNewMatchVM.createdItem.myDate, registeredUser: addNewMatchVM.createdItem.registeredUser, docId: addNewMatchVM.createdItem.docId, gameOver: addNewMatchVM.createdItem.gameOver)))
                    }
                }
                .onChange(of: addNewMatchVM.addNewSaved) { newValue in
                    if newValue {
                        self.isDocCreated = true
                    }
                }
            }
            .background(Color.cardColor)
        }
    }
    
    @ViewBuilder
    private var addNewMatchViewHeader: some View {
        VStack(spacing: 0) {
            Text("Digite a Pontuação Mínima de Vitória")
                .font(.headline)
                .foregroundStyle(Color.white)
            TextField("Digite a pontuação", text: $addNewMatchVM.targetScore)
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
                
                TextField(placeholderOne, text: $addNewMatchVM.playerOne)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField(placeholderTwo, text: $addNewMatchVM.playerTwo)
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
                
                TextField(placeholderThree, text: $addNewMatchVM.playerThree)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.textFieldBorderColor)
                    )
                    .minimumScaleFactor(0.4)
                
                TextField(placeholderFour, text: $addNewMatchVM.playerFour)
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
            
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(userRepo.listOfFriends, id: \.self) { friend in
                    
                    FriendGridItem(friend: friend, setSelectedButtonColor: $setSelectedButtonColor, cleanButtonColor: $cleanButtonColor) {
                        
                        if addNewMatchVM.playerOne.isEmpty {
                            placeholderOne = friend
                            addNewMatchVM.playerOne = friend
                            setSelectedButtonColor = true
                            cleanButtonColor = Color.black
                        } else if addNewMatchVM.playerTwo.isEmpty {
                            placeholderTwo = friend
                            addNewMatchVM.playerTwo = friend
                            setSelectedButtonColor = true
                        } else if addNewMatchVM.playerThree.isEmpty {
                            placeholderThree = friend
                            addNewMatchVM.playerThree = friend
                            setSelectedButtonColor = true
                        } else if addNewMatchVM.playerFour.isEmpty {
                            placeholderFour = friend
                            addNewMatchVM.playerFour = friend
                            setSelectedButtonColor = true
                        } else {
                            setSelectedButtonColor = false
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
}
