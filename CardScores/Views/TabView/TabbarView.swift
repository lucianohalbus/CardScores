//Created by Halbus Development

import SwiftUI

struct TabbarView: View {
    
    @Binding var showLoginView: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                TabView {
                    Group {
                        
                        NavigationStack {
                            AddNewBuracoMatchView()
                        }
                        .tabItem {
                            Image(systemName: "house.circle.fill")
                            Text("Inicio")
                        }
                        
                        NavigationStack {
                            BuracoListView()
                        }
                        .tabItem {
                            Image(systemName: "list.bullet.circle.fill")
                            Text("Partidas")
                        }
                        
                        NavigationStack {
                            ProfileView(showLoginView: $showLoginView)
                        }
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
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
}
