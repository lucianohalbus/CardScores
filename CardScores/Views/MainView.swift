//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @ObservedObject var login: LoginViewModel
    @State private var tabSelection: Int = 1
    @State private var IsUserAuthenticated: Bool = false
    @StateObject private var authenticationVM = AuthenticationViewModel()
    
    var body: some View {
        Group {
            TabView(selection: $tabSelection) {
                BuracoListView(tabSelection: $tabSelection, IsUserAuthenticated: $IsUserAuthenticated)
                    .tabItem {
                        Image(systemName: "lanyardcard.fill")
                        Text("Buraco")
                    }
                    .tag(1)

                LoginView(tabSelection: $tabSelection, isUserAuthenticated: $IsUserAuthenticated)
                    .tabItem {
                        Image(systemName: "gear.circle")
                        Text("User")
                    }
                    .tag(2)
            }
            .accentColor(.cardColor)
        }
        .onAppear(perform: {
            let authUser = try? authenticationVM.getAuthentication()
            self.IsUserAuthenticated = authUser != nil ? true : false
            
            if IsUserAuthenticated {
                self.tabSelection = 1
            } else {
                self.tabSelection = 2
            }
        })
    }
}
