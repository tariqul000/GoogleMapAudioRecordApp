//
//  AuthViewModel.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 11/11/21.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isValidate: Bool = false
    @Published var showingAlert: Bool = false
    @Published var isShowingRegistration: Bool = false



    private var cancleable = Set<AnyCancellable>()
    
    
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
    
    var emailError: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email"
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
