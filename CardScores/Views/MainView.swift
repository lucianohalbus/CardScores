//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @ObservedObject var login: LoginViewModel
    
    var body: some View {
        Group {
            TabView {
                BuracoListView()
                    .tabItem {
                        Image(systemName: "books.vertical.fill")
                        Text("Buraco")
                    }

                LoginView()
                    .tabItem {
                        Image(systemName: "gear.circle")
                        Text("User")
                    }
            }
        }
    }
}

#Preview {
    MainView(login: LoginViewModel())
}
