//
//  LoginViewModel.swift
//  CoachApp
//
//  Created by Иван Маришин on 21.11.2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class LoginViewModel: ObservableObject {
    
    //MARK: user info
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    //MARK: login view changer
    @Published var loginView: LoginViewChanger = .signIn
    
    //MARK: system change
    @Published var showingPasswordMessage: Bool = false
    @Published var showingLoginError: Bool = false
    @Published var showingSignUpError: Bool = false
    @Published var showingForgotAlert: Bool = false
    @Published var authError: EmailAuthError?
    @Published var errorString: String?
    
    enum LoginViewChanger {
        case signIn, forgot, signUp
    }
    
    //MARK: login?
    @Published var isUserAuthenticated: FBAuthState = .undefined
    @Published var user: FBUser = .init(uid: "", name: "", email: "")
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    enum FBAuthState {
        case undefined, signedOut, sigenIn
    }
    
    init() {
        configureFBStateDidChange()
    }
    
    func configureFBStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ _, user in
            guard let user = user else {
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .sigenIn
            
            FBFirestore.retrieveFBUser(uid: user.uid) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let user):
                    self.user = user
                }
            }
        })
    }
    
    func passwordsMatch(_confirmPW:String) -> Bool {
        return _confirmPW == password
    }
    
    func passConfirm() -> Color {
        if confirmPassword.isEmpty {
            return .secondary
        } else {
            return passwordsMatch(_confirmPW: confirmPassword) ? .blue.opacity(0.6):.secondary
        }
    }
    
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isPasswordValid(_password: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_email: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return passwordTest.evaluate(with: email)
    }
    
    func clearModel() {
        self.email.removeAll()
        self.fullname.removeAll()
        self.password.removeAll()
        self.confirmPassword.removeAll()
        self.loginView = .signIn
    }
    
    var isSignInComplete:Bool  {
        if  !isEmailValid(_email: email) ||
            isEmpty(_field: fullname) ||
            !isPasswordValid(_password: password) ||
            !passwordsMatch(_confirmPW: confirmPassword){
            return false
        }
        return true
    }
    
    var isLogInComplete:Bool {
        if isEmpty(_field: email) ||
            isEmpty(_field: password) {
            return false
        }
        return true
    }
}
