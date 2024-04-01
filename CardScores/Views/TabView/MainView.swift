//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @State private var showLoginView: Bool = false
    
    var body: some View {
        
        ZStack {
            if !showLoginView {
                TabbarView(showLoginView: $showLoginView)
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLoginView = authUser == nil
        }
        .fullScreenCover(isPresented: $showLoginView) {
            NavigationStack {
                LoginView(showLoginView: $showLoginView)
            }
        }
    }
}
