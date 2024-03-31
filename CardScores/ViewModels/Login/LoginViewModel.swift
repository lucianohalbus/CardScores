//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var login: [Login] = []
    @Published var password = ""
    @Published var email = ""
    @Published var loggedUser: Bool = false
    @Published var userId: String = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }

    func listen () {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.loggedUser = true
            } else {
                self.loggedUser = false
            }
        }
    }
    
    func anonymousLogin() {
        Auth.auth().signInAnonymously { authResult, error in
            if let userId = authResult?.user.uid {
                self.listen()
            } else {
                print(error?.localizedDescription ?? "No user found")
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self == nil else { return }
            self?.listen()
        }
    }

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch { print("already logged out")
        }
    }
    
}
