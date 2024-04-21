//Created by Halbus Development

import SwiftUI

struct RankingView: View {
    @StateObject var userRepo = UserRepository()
    @StateObject var buracoMatchVM = BuracoMatchViewModel()
    
    var body: some View {
        
        ZStack {
            ScrollView {
            VStack {
                MiniLogo()
                
                playerRanking
                    .padding(.bottom, 20)
                
                teamRanking
                
            }
            .frame(maxWidth: .infinity)
        }
        }
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
                    .font(.headline)
                    .fontWeight(.semibold)
                
            }
            
            ScrollView {
                HStack {
                    VStack {
                        Text("")
                    }
                    .frame(width: 20, alignment: .leading)
                    
                    VStack {
                        Text("Nome")
                    }
                    .frame(width: 150, alignment: .leading)
                    
                    VStack {
                        Text("Wins")
                    }
                    .frame(width: 35, alignment: .center)

                    VStack {
                        Text("Matches")
                    }
                    .frame(width: 60, alignment: .center)
                    
                    VStack {
                        Text("Rating")
                    }
                    .frame(width: 55, alignment: .center)
                }
                .font(.caption)
                .foregroundColor(.black)
                
                ForEach(Array(getPlayerRanking().enumerated()), id: \.element.id) { index, friend in
                    HStack {
                        VStack {
                            Text("\(index+1)")
                        }
                        .frame(width: 20, alignment: .leading)
                        
                        VStack {
                            Text("\(friend.name)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        VStack {
                            Text("\(friend.wins)")
                        }
                        .frame(width: 35, alignment: .center)
                        
                        VStack {
                            Text("\(friend.matches)")
                        }
                        .frame(width: 60, alignment: .center)
                        
                        VStack {
                            Text("\(getRating(wins: friend.wins, matches: friend.matches), specifier: "%.2f")")
                        }
                        .frame(width: 55, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundStyle(getRankingColor(index: index+1))
                    .fontWeight(index == 0 ? .bold : .regular)
                }
            }
            .background(Color.mainButtonColor)
            .cornerRadius(10)
        }
    }
    
    var teamRanking: some View {
        VStack {
            HStack {
                Text("Ranking de Duplas")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.semibold)
                
            }
            
            ScrollView {
                HStack {
                    VStack {
                        Text("")
                    }
                    .frame(width: 20, alignment: .leading)
                    
                    VStack {
                        Text("Dupla")
                    }
                    .frame(width: 150, alignment: .leading)
                    
                    VStack {
                        Text("Wins")
                    }
                    .frame(width: 35, alignment: .center)

                    VStack {
                        Text("Matches")
                    }
                    .frame(width: 60, alignment: .center)
                    
                    VStack {
                        Text("Rating")
                    }
                    .frame(width: 55, alignment: .center)
                }
                .font(.caption)
                .foregroundColor(.black)
                
                ForEach(Array(buracoMatchVM.getTeamsRanking(friends: userRepo.listOfFriends, matches: buracoMatchVM.matchesVM).enumerated()), id: \.element.id) { index, team in
               
                    HStack {
                        VStack {
                            Text("\(index+1)")
                        }
                        .frame(width: 20, alignment: .leading)
                        
                        VStack {
                            Text("\(team.playerOne) / \(team.playerTwo)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        VStack {
                            Text(team.numberofWins.description)
                        }
                        .frame(width: 35, alignment: .center)
                        
                        VStack {
                            Text(team.numberOfMatches.description)
                        }
                        .frame(width: 60, alignment: .center)
                        
                        VStack {
                            Text("\(team.rating, specifier: "%.2f")")
                        }
                        .frame(width: 55, alignment: .center)
                    }
                    .font(.caption)
                    .foregroundStyle(getRankingColor(index: index+1))
                    .fontWeight(index == 0 ? .bold : .regular)
                }
            }
            .background(Color.mainButtonColor)
            .cornerRadius(10)
        }
    }
    
    
    func getRankingColor(index: Int) -> Color {
        switch index {
        case 1:
            return Color.rankingOne
        case 2:
            return Color.rankingTwo
        case 3:
            return Color.rankingThree
            
        default:
            return Color.black
        }
    }
    
}

#Preview {
    RankingView()
}
