//Created by Halbus Development

import SwiftUI

struct BuracoOnlineMatchView: View {
    @EnvironmentObject var cardsVM: CardsViewModel

    var body: some View {
        GeometryReader { _ in
            ZStack {
                GameAreaOneView()
                GameAreaTwoView()
                MainDeckView(onlinePlayerModel: $cardsVM.onlinePlayerOne) {

                }
                RivalDeckTopView(onlinePlayerModel: $cardsVM.onlinePlayerTwo) {
                    
                }
                RivalDeckLeftView(onlinePlayerModel: $cardsVM.onlinePlayerThree) {
                    
                }
                RivalDeckRightView(onlinePlayerModel: $cardsVM.onlinePlayerFour) {
                    
                }
                SecondDeckTwoView(deck: $cardsVM.onlineBuracoModel.deckSecondOne)
                SecondDeckOneView(deck: $cardsVM.onlineBuracoModel.deckSecondTwo)
                
                DeckRefillView(deck: $cardsVM.onlineBuracoModel.deckRefill) {
                    if cardsVM.deckRefill.count > 0 {
                        if let card = cardsVM.deckRefill.last {
                            if cardsVM.isPlayerOneTurn {
                                cardsVM.onlinePlayerOne.deckPlayer.append(card)
                                cardsVM.isPlayerOneTurn = false
                                cardsVM.isPlayerTwoTurn = false
                                cardsVM.isPlayerThreeTurn = false
                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = true
                                cardsVM.isPlayerTwoDiscarding = false
                                cardsVM.isPlayerThreeDiscarding = false
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.isPlayerTwoTurn {
                                cardsVM.onlinePlayerTwo.deckPlayer.append(card)
                                cardsVM.isPlayerOneTurn = false
                                cardsVM.isPlayerTwoTurn = false
                                cardsVM.isPlayerThreeTurn = false
                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = false
                                cardsVM.isPlayerTwoDiscarding = false
                                cardsVM.isPlayerThreeDiscarding = true
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.isPlayerThreeTurn {
                                cardsVM.onlinePlayerThree.deckPlayer.append(card)
                                cardsVM.isPlayerOneTurn = false
                                cardsVM.isPlayerTwoTurn = false
                                cardsVM.isPlayerThreeTurn = false
                                cardsVM.isPlayerFourTurn = false
                                cardsVM.isBuyingFromDeckRefill = false
                                cardsVM.isBuyingFromDiscards = false
                                cardsVM.shoudDiscard = true
                                cardsVM.isPlayerOneDiscarding = false
                                cardsVM.isPlayerTwoDiscarding = true
                                cardsVM.isPlayerThreeDiscarding = false
                                cardsVM.isPlayerFourDiscarding = false
                                cardsVM.auxDeck.removeAll()
                            } else if cardsVM.isPlayerFourTurn {
                                cardsVM.onlinePlayerFour.deckPlayer.append(card)
                                cardsVM.isPlayerOneTurn = false
                                cardsVM.isPlayerTwoTurn = false
                                cardsVM.isPlayerThreeTurn = false
                                cardsVM.isPlayerFourTurn = false
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
                        cardsVM.discardDeck.append(contentsOf: cardsVM.auxDeck)
                        cardsVM.onlinePlayerOne.deckPlayer.removeAll { card in
                            card == cardsVM.auxDeck.first
                        }
                        cardsVM.isPlayerOneTurn = false
                        cardsVM.isPlayerTwoTurn = false
                        cardsVM.isPlayerThreeTurn = true
                        cardsVM.isPlayerFourTurn = false
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
                        cardsVM.discardDeck.append(contentsOf: cardsVM.auxDeck)
                        cardsVM.onlinePlayerTwo.deckPlayer.removeAll { card in
                            card == cardsVM.auxDeck.first
                        }
                        cardsVM.isPlayerOneTurn = false
                        cardsVM.isPlayerTwoTurn = false
                        cardsVM.isPlayerThreeTurn = false
                        cardsVM.isPlayerFourTurn = true
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
                        cardsVM.discardDeck.append(contentsOf: cardsVM.auxDeck)
                        cardsVM.onlinePlayerThree.deckPlayer.removeAll { card in
                            card == cardsVM.auxDeck.first
                        }
                        cardsVM.isPlayerOneTurn = false
                        cardsVM.isPlayerTwoTurn = true
                        cardsVM.isPlayerThreeTurn = false
                        cardsVM.isPlayerFourTurn = false
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
                        cardsVM.discardDeck.append(contentsOf: cardsVM.auxDeck)
                        cardsVM.onlinePlayerFour.deckPlayer.removeAll { card in
                            card == cardsVM.auxDeck.first
                        }
                        cardsVM.isPlayerOneTurn = true
                        cardsVM.isPlayerTwoTurn = false
                        cardsVM.isPlayerThreeTurn = false
                        cardsVM.isPlayerFourTurn = false
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green, ignoresSafeAreaEdges: .all)
            .onAppear {
                
        }
        }
    }
}

#Preview {
    BuracoOnlineMatchView()
        .environmentObject(CardsViewModel())
}
