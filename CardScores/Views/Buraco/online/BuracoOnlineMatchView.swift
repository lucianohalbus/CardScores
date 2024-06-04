//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct BuracoOnlineMatchView: View {
    @EnvironmentObject var cardsVM: CardsViewModel
    @EnvironmentObject var settings: BuracoSettings

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let playerId: String = Auth.auth().currentUser?.uid {
                    if playerId == cardsVM.onlineBuracoModel.playerOne.playerID {
                        MainDeckView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerOne)
                        RivalDeckTopView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerTwo) { }
                        RivalDeckLeftView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerThree) { }
                        RivalDeckRightView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerFour) { }
                    } else if playerId == cardsVM.onlineBuracoModel.playerTwo.playerID {
                        MainDeckView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerTwo)
                        RivalDeckTopView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerOne) { }
                        RivalDeckLeftView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerThree) { }
                        RivalDeckRightView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerFour) { }
                    } else if playerId == cardsVM.onlineBuracoModel.playerThree.playerID {
                        MainDeckView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerThree)
                        RivalDeckTopView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerFour) { }
                        RivalDeckLeftView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerOne) { }
                        RivalDeckRightView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerTwo) { }
                    } else if playerId == cardsVM.onlineBuracoModel.playerFour.playerID {
                        MainDeckView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerFour)
                        RivalDeckTopView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerThree) { }
                        RivalDeckLeftView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerOne) { }
                        RivalDeckRightView(onlinePlayerModel: $cardsVM.onlineBuracoModel.playerTwo) { }
                    }
                }
                
                GameAreaOneView()
                GameAreaTwoView()
                SecondDeckTwoView(deck: $cardsVM.onlineBuracoModel.deckSecondTwo)
                SecondDeckOneView(deck: $cardsVM.onlineBuracoModel.deckSecondOne)
                
                DeckRefillView(deck: $cardsVM.onlineBuracoModel.deckRefill) {
                    if cardsVM.onlineBuracoModel.deckRefill.count > 0 {
                        if let card = cardsVM.onlineBuracoModel.deckRefill.last {
                            if cardsVM.onlineBuracoModel.isPlayerOneTurn {
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = true
                                cardsVM.isPlayerTwoDiscarding = false
                                cardsVM.isPlayerThreeDiscarding = false
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.onlineBuracoModel.isPlayerTwoTurn {
                                cardsVM.onlineBuracoModel.playerTwo.deckPlayer.append(card)
//                                cardsVM.isPlayerOneTurn = false
//                                cardsVM.isPlayerTwoTurn = false
//                                cardsVM.isPlayerThreeTurn = false
//                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = false
                                cardsVM.isPlayerTwoDiscarding = false
                                cardsVM.isPlayerThreeDiscarding = true
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.onlineBuracoModel.isPlayerThreeTurn {
                                cardsVM.onlineBuracoModel.playerThree.deckPlayer.append(card)
//                                cardsVM.isPlayerOneTurn = false
//                                cardsVM.isPlayerTwoTurn = false
//                                cardsVM.isPlayerThreeTurn = false
//                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = false
                                cardsVM.isPlayerTwoDiscarding = true
                                cardsVM.isPlayerThreeDiscarding = false
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.onlineBuracoModel.isPlayerFourTurn {
                                cardsVM.onlineBuracoModel.playerFour.deckPlayer.append(card)
//                                cardsVM.isPlayerOneTurn = false
//                                cardsVM.isPlayerTwoTurn = false
//                                cardsVM.isPlayerThreeTurn = false
//                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = false
                                cardsVM.isPlayerTwoDiscarding = false
                                cardsVM.isPlayerThreeDiscarding = false
                                cardsVM.isPlayerFourDiscarding = true
                                cardsVM.auxDeck.removeAll()
                            }
                        }
                    }
                }
                
                DiscardAreaView() {
                    
                } onDiscard: {
                   if cardsVM.isPlayerOneDiscarding {
//                        cardsVM.onlineBuracoModel.deckDiscard.append(contentsOf: cardsVM.auxDeck)
                     //   cardsVM.onlinePlayerOne.deckPlayer.removeAll { card in
                    //        card == cardsVM.auxDeck.first
                    //    }
   
                        let cardToDiscard: CardModel = cardsVM.auxDiscardDeck
                        cardsVM.updateDeckDiscard(deckDiscard: cardToDiscard)
                        
                 //       cardsVM.updatePlayerDeck(deckPlayer: cardsVM.onlinePlayerOne.deckPlayer, onlinePlayer: cardsVM.onlinePlayerOne)
//                        cardsVM.isPlayerOneTurn = false
//                        cardsVM.isPlayerTwoTurn = false
//                        cardsVM.isPlayerThreeTurn = true
//                        cardsVM.isPlayerFourTurn = false
                        cardsVM.isSecondDeckOneAvailable = true
                        cardsVM.isSecondDeckTwoAvailable = true
                        cardsVM.isBuyingFromDeckRefill = true
                        cardsVM.isBuyingFromDiscards = true
                        cardsVM.shoudDiscard = false
                        cardsVM.isPlayerOneDiscarding = false
                        cardsVM.isPlayerTwoDiscarding = false
                        cardsVM.isPlayerThreeDiscarding = false
                        cardsVM.isPlayerFourDiscarding = false
                    } else if cardsVM.isPlayerTwoDiscarding {
                    //    cardsVM.onlineBuracoModel.deckDiscard.append(contentsOf: cardsVM.auxDeck)
//                        cardsVM.onlinePlayerTwo.deckPlayer.removeAll { card in
//                            card == cardsVM.auxDeck.first
//                        }
//                        cardsVM.isPlayerOneTurn = false
//                        cardsVM.isPlayerTwoTurn = false
//                        cardsVM.isPlayerThreeTurn = false
//                        cardsVM.isPlayerFourTurn = true
                        cardsVM.isSecondDeckOneAvailable = true
                        cardsVM.isSecondDeckTwoAvailable = true
                        cardsVM.isBuyingFromDeckRefill = true
                        cardsVM.isBuyingFromDiscards = true
                        cardsVM.shoudDiscard = false
                        cardsVM.isPlayerOneDiscarding = false
                        cardsVM.isPlayerTwoDiscarding = false
                        cardsVM.isPlayerThreeDiscarding = false
                        cardsVM.isPlayerFourDiscarding = false
                    } else if cardsVM.isPlayerThreeDiscarding {
                   //     cardsVM.onlineBuracoModel.deckDiscard.append(contentsOf: cardsVM.auxDeck)
//                        cardsVM.onlinePlayerThree.deckPlayer.removeAll { card in
//                            card == cardsVM.auxDeck.first
//                        }
//                        cardsVM.isPlayerOneTurn = false
//                        cardsVM.isPlayerTwoTurn = true
//                        cardsVM.isPlayerThreeTurn = false
//                        cardsVM.isPlayerFourTurn = false
                        cardsVM.isSecondDeckOneAvailable = true
                        cardsVM.isSecondDeckTwoAvailable = true
                        cardsVM.isBuyingFromDeckRefill = true
                        cardsVM.isBuyingFromDiscards = true
                        cardsVM.shoudDiscard = false
                        cardsVM.isPlayerOneDiscarding = false
                        cardsVM.isPlayerTwoDiscarding = false
                        cardsVM.isPlayerThreeDiscarding = false
                        cardsVM.isPlayerFourDiscarding = false
                    } else if cardsVM.isPlayerFourDiscarding {
                   //     cardsVM.onlineBuracoModel.deckDiscard.append(contentsOf: cardsVM.auxDeck)
//                        cardsVM.onlinePlayerFour.deckPlayer.removeAll { card in
//                            card == cardsVM.auxDeck.first
//                        }
//                        cardsVM.isPlayerOneTurn = true
//                        cardsVM.isPlayerTwoTurn = false
//                        cardsVM.isPlayerThreeTurn = false
//                        cardsVM.isPlayerFourTurn = false
                        cardsVM.isSecondDeckOneAvailable = true
                        cardsVM.isSecondDeckTwoAvailable = true
                        cardsVM.isBuyingFromDeckRefill = true
                        cardsVM.isBuyingFromDiscards = true
                        cardsVM.shoudDiscard = false
                        cardsVM.isPlayerOneDiscarding = false
                        cardsVM.isPlayerTwoDiscarding = false
                        cardsVM.isPlayerThreeDiscarding = false
                        cardsVM.isPlayerFourDiscarding = false
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .padding(proxy.safeAreaInsets)
            .background(Color.green, ignoresSafeAreaEdges: .all)
            .navigationBarHidden(true)
            .onChange(of: cardsVM.cardDeletedFromDeckRefill) { newValue in
                if newValue {
                    Task {
                        try await cardsVM.getOnlineBuraco(onlineBuracoID: cardsVM.onlineBuracoModel.id)
                    }
                    cardsVM.cardDeletedFromDeckRefill = false
                }
            }
            .onChange(of: cardsVM.deckPlayerUpdated) { newValue in
                if newValue {
                    Task {
                        try await cardsVM.getOnlineBuraco(onlineBuracoID: cardsVM.onlineBuracoModel.id)
                    }
                    cardsVM.deckPlayerUpdated = false
                }
            }
            .onChange(of: cardsVM.deckRefillUpdated) { newValue in
                if newValue {
                    Task {
                        try await cardsVM.getOnlineBuraco(onlineBuracoID: cardsVM.onlineBuracoModel.id)
                    }
                    cardsVM.deckRefillUpdated = false
                }
            }
            .onChange(of: cardsVM.isPlayerInvited) { newValue in
                if newValue {
                    Task {
                       try await settings.updatePlayerInvite()
                    }
                }
            }
            .onChange(of: settings.isOnlineBuracoUpdated) { newValue in
                if newValue {
                    Task {
                        try await cardsVM.getOnlineBuraco(onlineBuracoID: settings.gameID)
                    }
                }
            }
            .onAppear {
                Task {
                    try await cardsVM.getOnlineBuraco(onlineBuracoID: settings.gameID)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BuracoOnlineMatchView()
        .environmentObject(CardsViewModel())
        .environmentObject(BuracoSettings())
}
