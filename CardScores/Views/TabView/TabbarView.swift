//Created by Halbus Development

import SwiftUI

struct TabbarView: View {
    
    @Binding var showLoginView: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
              BuracoListView()
            }
            .tabItem {
                Image(systemName: "lanyardcard.fill")
                Text("Buraco")
            }
            
            NavigationStack {
                ProfileView(showLoginView: $showLoginView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
        .tint(Color.cardColor)
    }
}

#Preview {
    TabbarView(showLoginView: .constant(false))
}
