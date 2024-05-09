//Created by Halbus Development

import SwiftUI

struct RankingView: View {
    @EnvironmentObject var userRepo: UserRepository
    @StateObject var buracoMatchVM = BuracoMatchViewModel()
    
    enum SelectRanking: String, CodingKey, CaseIterable {
        case individual = "Individual"
        case general = "Geral"
    }
    
    @State var selectedRanking: SelectRanking = .individual
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack {
                    MiniLogo()
                    if userRepo.isUserAnonymous {
                        Text("Crie uma conta para ter")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .padding(.top, 10)
                        
                        Text("acesso ao ranking.")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .padding(.bottom, 20)
                        
                        Text("Para criar uma conta")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                        
                        HStack {
                            Text("acesse a aba")
                            Text("Profile")
                                .foregroundStyle(Color.yellow)
                            Text("\(Image(systemName: "person.crop.circle.fill"))")
                            Text("abaixo.")
                        }
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 20)
                        
                    } else {
                        
                        Picker("Select Ranking", selection: $selectedRanking) {
                            ForEach(SelectRanking.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .font(.title)
                        .fontWeight(.bold)
                        .background(Color.green)
                        .foregroundColor(Color.cardColor)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        .pickerStyle(.segmented)
                        
                        switch self.selectedRanking {
                        case .individual:
                            playerRanking
                                .padding(.bottom, 10)
                            
                            teamRanking
                            
                        case .general:
                            playerGeneralRanking
                                .padding(.bottom, 10)
                            
                            teamGeneralRanking
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.cardColor)
        .onAppear {
            userRepo.getUser()
            buracoMatchVM.getMatches()
            buracoMatchVM.getAllMatches()
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
                .padding(.horizontal, 5)
                
                ForEach(Array(buracoMatchVM.getPlayersRanking(matches: buracoMatchVM.matchesVM).enumerated()).prefix(10), id: \.element.id) { index, player in
                    if player.numberOfMatches > 0 {
                        HStack {
                            VStack {
                                Text("\(index+1)")
                            }
                            .frame(width: 20, alignment: .leading)
                            
                            VStack {
                                Text("\(player.player)")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            VStack {
                                Text("\(player.numberofWins)")
                            }
                            .frame(width: 35, alignment: .center)
                            
                            VStack {
                                Text("\(player.numberOfMatches)")
                            }
                            .frame(width: 60, alignment: .center)
                            
                            VStack {
                                Text("\(getRating(wins: player.numberofWins, matches: player.numberOfMatches), specifier: "%.2f")")
                            }
                            .frame(width: 55, alignment: .center)
                        }
                        .font(.caption)
                        .foregroundStyle(getRankingColor(index: index+1))
                        .fontWeight(index == 0 ? .bold : .regular)
                        .padding(.horizontal, 5)
                    }
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
                .padding(.horizontal, 5)
                
                ForEach(Array(buracoMatchVM.getTeamsRanking(matches: buracoMatchVM.matchesVM).enumerated()).prefix(10), id: \.element.id) { index, team in
                    if team.numberOfMatches > 0 {
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
                        .padding(.horizontal, 5)
                    }
                }
            }
            .background(Color.mainButtonColor)
            .cornerRadius(10)
        }
    }
    
    var playerGeneralRanking: some View {
        VStack {
            HStack {
                Text("Ranking Individual Geral")
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
                .padding(.horizontal, 5)
                
                ForEach(Array(buracoMatchVM.getGeneralPlayersRanking(matches: buracoMatchVM.rankingMatches).enumerated()).prefix(10), id: \.element.id) { index, player in
                    if player.numberOfMatches > 0 {
                        HStack {
                            VStack {
                                Text("\(index+1)")
                            }
                            .frame(width: 20, alignment: .leading)
                            
                            VStack {
                                Text("\(player.player)")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            VStack {
                                Text("\(player.numberofWins)")
                            }
                            .frame(width: 35, alignment: .center)
                            
                            VStack {
                                Text("\(player.numberOfMatches)")
                            }
                            .frame(width: 60, alignment: .center)
                            
                            VStack {
                                Text("\(getRating(wins: player.numberofWins, matches: player.numberOfMatches), specifier: "%.2f")")
                            }
                            .frame(width: 55, alignment: .center)
                        }
                        .font(.caption)
                        .foregroundStyle(getRankingColor(index: index+1))
                        .fontWeight(index == 0 ? .bold : .regular)
                        .padding(.horizontal, 5)
                    }
                }
            }
            .background(Color.mainButtonColor)
            .cornerRadius(10)
        }
    }
    
    var teamGeneralRanking: some View {
        VStack {
            HStack {
                Text("Ranking de Duplas Geral")
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
                .padding(.horizontal, 5)
                
                ForEach(Array(buracoMatchVM.getGeneralTeamsRanking(matches: buracoMatchVM.rankingMatches).enumerated()).prefix(10), id: \.element.id) { index, team in
                    if team.numberOfMatches > 0 {
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
                        .padding(.horizontal, 5)
                    }
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
