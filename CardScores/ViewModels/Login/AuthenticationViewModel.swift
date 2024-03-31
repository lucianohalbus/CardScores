//Created by Halbus Development

import Foundation
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isUserAuthenticated: Bool = false
    
    var repo = AuthenticationManager()
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }
    
    func getAuthentication() throws -> AuthDataResultModel {
       return try repo.getAuthenticatedUser()
    }
    
    func listen () {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                self.isUserAuthenticated = false
                return
            }
            
            self.isUserAuthenticated = true
            
        }
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        
        _ = try await repo.createUser(email: email, password: password)
        self.listen()
    }

    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        
        _ = try await repo.signInUser(email: email, password: password)
        self.listen()
    }
    
    func logOut() throws {
        try repo.signOut()
        self.listen()
    }
}
