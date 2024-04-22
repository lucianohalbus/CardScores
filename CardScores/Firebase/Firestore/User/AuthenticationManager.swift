//Created by Halbus Development

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    var alertMessage: String = ""
    var alertSuggestion: String = ""
    var showAlert: Bool = false
    
    static let shared = AuthenticationManager()
    init() {}
    
    // Authenticate locally
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // Create a new user on Firebase Authentication facility
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign In with a existent user
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        user.delete { error in
            if error != nil {
              self.alertMessage = "Essa operação requer reautenticação do usuário"
              self.alertSuggestion = "Por favor, saia do aplicativo, entre novamente e tente deletar sua conta novamente."
              self.showAlert = true
          } else {
              self.alertMessage = "Sua conta foi apagada."
              self.alertSuggestion = "Volte sempre que quiser."
              self.showAlert = true
          }
        }
    }
    
}
