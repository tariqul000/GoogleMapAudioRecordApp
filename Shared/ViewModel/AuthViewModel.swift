//
//  AuthViewModel.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import Foundation
import Combine
import Firebase

final class AuthViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isValidate: Bool = false
    @Published var showingAlert: Bool = false
    @Published var isShowingRegistration: Bool = false
    private var cancleable = Set<AnyCancellable>()

    
    //firebase
    var didChange = PassthroughSubject<AuthViewModel, Never>()
    var session: UserModel? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    
    func listen () {
            // monitor authentication changes using firebase
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    // if we have a user, create a new user model
                    print("GotUser: \(user)")
                    self.session = UserModel(
                        uid: user.uid,
                        displayName: user.displayName, email: user.email                    )
                } else {
                    // if we don't have a user, set our session to nil
                    self.session = nil
                }
            }
        }

    func signUp(
        name: String,
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }

    
    func submitLoginRequest() {
        if isEmailValid() && isPasswordValid(){
            isLoading = true
        } else {
            isValidate.toggle()
        }
    }
    
    func isEmailValid() -> Bool {
        // criteria in regex.  See http://regexlib.com
        let phoneTest = NSPredicate(format: "SELF MATCHES %@",
                                    "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return phoneTest.evaluate(with: email)
    }
    
    func isPasswordValid() -> Bool {
        if password.isEmpty {
            return false
        }
        return true
    }
    
    func isNameValid() -> Bool {
        if name.isEmpty {
            return false
        }
        return true
    }
    
    var emailError: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email"
        }
    }
    
    var nameError: String {
        if isNameValid() {
            return ""
        } else {
            return "Enter a valid anem"
        }
    }
    var passwordError: String {
        if isPasswordValid() {
            return ""
        } else {
            return "Enter a valid password"
        }
    }
    
   
    
}
