//Created by Halbus Development

import SwiftUI

enum MainNavigation: Hashable {
    case child(BuracoFBViewModel)
    case anotherChild
}

struct TabbarView: View {
    @Binding var showLoginView: Bool
    
    enum Tab {
      case inicio, partidas, ranking, online, profile
     }
    
    @State private var selectedTab: Tab = .inicio
    @State private var mainNavigationStack: [MainNavigation] = []
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                TabView(selection: tabSelection()) {
                    Group {

                        BuracoPresencialStartView(path: $mainNavigationStack)
                            .tabItem {
                                Image(systemName: "house.circle.fill")
                                Text("Inicio")
                            }
                            .tag(Tab.inicio)
                        
                        BuracoListView(path: $mainNavigationStack)
                            .tabItem {
                                Image(systemName: "rectangle.on.rectangle.circle.fill")
                                Text("Partidas")
                            }
                            .tag(Tab.partidas)
                        
                        RankingView()
                            .tabItem {
                                Image(systemName: "list.bullet.circle.fill")
                                Text("Ranking")
                            }
                            .tag(Tab.ranking)
                        
                        BuracoOnlineStartView(path: $mainNavigationStack)
                            .tabItem {
                                Image(systemName: "wifi.circle")
                                Text("Online")
                            }
                            .tag(Tab.online)
                        
                        ProfileView(showLoginView: $showLoginView, path: $mainNavigationStack)
                            .tabItem {
                                Image(systemName: "person.crop.circle.fill")
                                Text("Profile")
                            }
                            .tag(Tab.profile)
                    }
                    .toolbarBackground(Color.cardColor.opacity(0.2), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.light, for: .tabBar)
                }
                .tint(Color.white)
            }
        }
    }
}

#Preview {
    TabbarView(showLoginView: .constant(false))
        .environmentObject(BuracoMatchViewModel())
        .environmentObject(CardsViewModel())
        .environmentObject(BuracoSettings())
    
}

extension TabbarView {
    
    private func tabSelection() -> Binding<Tab> {
        Binding { //this is the get block
            self.selectedTab
        } set: { tappedTab in
            
            mainNavigationStack = []
            
            if tappedTab == self.selectedTab {
                //User tapped on the currently active tab icon => Pop to root/Scroll to top
                
                
                
                if mainNavigationStack.isEmpty {
                    //User already on home view, scroll to top
                    
                } else {
                    //Pop to root view by clearing the stack
                    mainNavigationStack = []
                }
            }
            
            //Set the current tab to the user selected tab
            self.selectedTab = tappedTab
        }
    }
    
}
