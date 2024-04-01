//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var login: [Login] = []
    @Published var password = ""
    @Published var email = ""
    @Published var userId: String = ""
    @Published var errorString: String = ""
    @Published var errorSuggestion: String = ""
    @Published var showAlertError: Bool = false
    @Published var userAuthenticated: Bool = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listen()
    }

    func listen () {
        //monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                print("SUCCESSFULLY LOGGED")
                self.userAuthenticated = true
            } else {
                print("ERROR TRYING TO LOG IN")
            }
        }
    }
    
    func anonymousLogin() {
        Auth.auth().signInAnonymously { authResult, error in
            if let userId = authResult?.user.uid {
                print(userId)
                self.listen()
                self.userAuthenticated = true
            } else {
                print(error?.localizedDescription ?? "No user found")
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (auth, error) in
            if let returnedError = error {
                let err = returnedError as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.errorString = "Wrong Email and/or Password"
                    self.errorSuggestion = "Check the entered email and/or password"
                case AuthErrorCode.invalidEmail.rawValue:
                    self.errorString = "Wrong Email and/or Password"
                    self.errorSuggestion = "Check the entered email and/or password"
                case AuthErrorCode.userNotFound.rawValue:
                    self.errorString = "User not found"
                    self.errorSuggestion = "Check your email address or create an account"
                default:
                    self.errorString = "unknown error: \(err.localizedDescription)"
                }
                self.showAlertError = true     
            } else {
                if let _ = auth?.user {
                    self.listen()
                    self.userAuthenticated = true
                    
                } else {
                    print("no authd user")
                }
            }
        })
        
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//            
//            if let error = error {
//                self?.errorString = error.localizedDescription
//            }
//            
//            guard self == nil else { return }
//            self?.listen()
//            
//        }
    }

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            self.userAuthenticated = true
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.password = ""
            self.email = ""
            self.userId = ""
        } catch { 
            print("already logged out")
            self.userAuthenticated = false
        }
    }
    
}
