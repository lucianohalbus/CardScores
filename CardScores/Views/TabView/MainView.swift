//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @State private var showLoginView: Bool = false
    @StateObject var userVM = UserViewModel()

    
    var body: some View {
        
        ZStack {
            if !showLoginView {
                TabbarView(showLoginView: $showLoginView)
            }
        }
        .onAppear {
            Task {
                do {
                    let currentUser: ProfileModel = try await userVM.getUser()
                    if !currentUser.userId.isEmpty {
                        self.showLoginView = false
                    }
                    
                } catch {
                    self.showLoginView = true
                }
                
            }
            
           
            
        }
        .fullScreenCover(isPresented: $showLoginView) {
            NavigationStack {
                LoginView(showLoginView: $showLoginView)
            }
        }
    }
}
