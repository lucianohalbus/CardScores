//Created by Halbus Development

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var login: [Login] = []
    @Published var password = ""
    @Published var email = ""
    @Published var userId: String = ""
    @Published var alertMessage: String = ""
    @Published var alertSuggestion: String = ""
    @Published var showAlert: Bool = false
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
                    self.alertMessage = "Wrong Email and/or Password"
                    self.alertSuggestion = "Check the entered email and/or password"
                case AuthErrorCode.invalidEmail.rawValue:
                    self.alertMessage = "Wrong Email and/or Password"
                    self.alertSuggestion = "Check the entered email and/or password"
                case AuthErrorCode.userNotFound.rawValue:
                    self.alertMessage = "User not found"
                    self.alertSuggestion = "Check your email address or create an account"
                default:
                    self.alertMessage = "Error"
                    self.alertSuggestion = "\(err.localizedDescription)"
                }
                self.showAlert = true     
            } else {
                if let _ = auth?.user {
                    self.listen()
                    self.userAuthenticated.toggle()
                    
                } else {
                    print("no authd user")
                }
            }
        })
    }

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let returnedError = error {
                let err = returnedError as NSError
                switch err.code {
                case AuthErrorCode.invalidEmail.rawValue:
                    self.alertMessage = "Invalid Email"
                    self.alertSuggestion = "Enter a valid email address"
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.alertMessage = "Email is already in use"
                    self.alertSuggestion = "If this is your email, reset the password"
                case AuthErrorCode.weakPassword.rawValue:
                    self.alertMessage = "Weak Password"
                    self.alertSuggestion = "Password must be 6 characters long or more"
                default:
                    self.alertMessage = "Error"
                    self.alertSuggestion = "\(err.localizedDescription)"
                }
                self.showAlert = true
            } else {
                if let _ = result?.user {
                    self.listen()
                    self.userAuthenticated.toggle()
                    
                } else {
                    print("no authd user")
                }
            }
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
    
    func resetPassword(email: String)  {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (anyError) in
            
            if let returnedError = anyError {
                let err = returnedError as NSError
                switch err.code {
                case AuthErrorCode.invalidEmail.rawValue:
                    self.alertMessage = "Error"
                    self.alertSuggestion = "There is no user record corresponding to this identifier"
                default:
                    self.alertMessage = "Error"
                    self.alertSuggestion = "There is no user record corresponding to this identifier"
                }
                self.showAlert = true
            } else {
                
                self.alertMessage = "Success"
                self.alertSuggestion = "A link to reset your password has been sent to your email."
                self.showAlert = true
            }
        })
    }
    
}
