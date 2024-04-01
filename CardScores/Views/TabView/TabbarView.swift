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
                Image(systemName: "cart")
                Text("Products")
            }
            
            NavigationStack {
                ProfileView(showLoginView: $showLoginView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

#Preview {
    TabbarView(showLoginView: .constant(false))
}
