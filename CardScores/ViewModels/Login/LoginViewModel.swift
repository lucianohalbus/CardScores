//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var login:[Login] = []
    @Published var password = ""
    @Published var email = ""
    @Published var loggedUser: Bool = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        Listen()
    }

    func Listen () {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.loggedUser = true
            } else {
                self.loggedUser = false
            }
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self == nil else { return }
            
            self?.Listen()
            
            
        }
    }

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return}
        }
    }
    
    func unbind() {
        if let handle = handle {
            do {
                try Auth.auth().signOut()
            } catch { print("already logged out")
            }
            
            
            //Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
}
