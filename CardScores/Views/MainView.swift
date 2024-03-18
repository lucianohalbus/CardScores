//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @ObservedObject var login: LoginViewModel
    @State private var tabSelection: Int = 2
    
    var body: some View {
        Group {
            TabView(selection: $tabSelection) {
                BuracoListView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "lanyardcard.fill")
                        Text("Buraco")
                    }
                    .tag(2)

                LoginView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "gear.circle")
                        Text("User")
                    }
                    .tag(1)
            }
            .accentColor(.cardColor)
        }
        .onAppear(perform: {
            if Auth.auth().currentUser?.uid != nil {
                self.tabSelection = 2
            } else {
                self.tabSelection = 1
            }
        })
    }
}
