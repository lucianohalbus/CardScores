//Created by Halbus Development

import SwiftUI

struct RankingView: View {
    @StateObject var userRepo = UserRepository()
    @StateObject var buracoMatchVM = BuracoMatchViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                MiniLogo()
                
                playerRanking
                
                teamRanking
     
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cardColor)
        .onAppear {
            userRepo.getUser()
            buracoMatchVM.getMatches()
        }
        .onChange(of: buracoMatchVM.matchesVM) { newValue in
            buracoMatchVM.getTeamsRanking(friends: userRepo.listOfFriends, matches: buracoMatchVM.matchesVM)
        }
    }
    
    var playerRanking: some View {
        VStack {
            HStack {
                Text("Ranking Individual")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            .frame(width: 350, alignment: .center)
            
            ScrollView {
                HStack {
                    VStack {
                        Text("Nome")
                    }
                    .frame(width: 110, alignment: .leading)
                    
                    VStack {
                        Text("Vitórias")
                    }
                    .frame(width: 80, alignment: .center)

                    VStack {
                        Text("Partidas")
                    }
                    .frame(width: 80, alignment: .center)
                    
                    VStack {
                        Text("Rating")
                    }
                    .frame(width: 80, alignment: .center)
                }
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
                ForEach(getPlayerRanking(), id: \.self) { friend in
                    HStack {
                        VStack {
                            Text("\(friend.name)")
                        }
                        .frame(width: 110, alignment: .leading)
                        
                        VStack {
                            Text("\(friend.wins)")
                        }
                        .frame(width: 80, alignment: .center)
                        
                        VStack {
                            Text("\(friend.matches)")
                        }
                        .frame(width: 80, alignment: .center)
                        
                        VStack {
                            Text("\(getRating(wins: friend.wins, matches: friend.matches), specifier: "%.2f")")
                        }
                        .frame(width: 80, alignment: .center)
                    }
                    .font(.callout)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    
                }
            }
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
    }
    
    var teamRanking: some View {
        VStack {
            HStack {
                Text("Ranking de Duplas")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
            .frame(width: 350, alignment: .center)
            
            ScrollView {
                HStack {
                    VStack {
                        Text("Dupla")
                    }
                    .frame(width: 110, alignment: .leading)
                    
                    VStack {
                        Text("Vitórias")
                    }
                    .frame(width: 80, alignment: .center)

                    VStack {
                        Text("Partidas")
                    }
                    .frame(width: 80, alignment: .center)
                    
                    VStack {
                        Text("Rating")
                    }
                    .frame(width: 80, alignment: .center)
                }
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
                ForEach(buracoMatchVM.getTeamsRanking(friends: userRepo.listOfFriends, matches: buracoMatchVM.matchesVM), id: \.self) { team in
                    HStack {
                        VStack {
                            Text("\(team.playerOne) / \(team.playerTwo)")
                        }
                        .frame(width: 110, alignment: .leading)
                        
                        VStack {
                            Text(team.numberofWins.description)
                        }
                        .frame(width: 80, alignment: .center)
                        
                        VStack {
                            Text(team.numberOfMatches.description)
                        }
                        .frame(width: 80, alignment: .center)
                        
                        VStack {
                            Text("\(team.rating, specifier: "%.2f")")
                        }
                        .frame(width: 80, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    
                }
            }
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
    }
    
    
    
    
}

#Preview {
    RankingView()
}
