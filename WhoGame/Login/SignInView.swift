//
//  SignInView.swift
//  CoachApp
//
//  Created by Иван Маришин on 21.11.2021.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        gameManager.skipSignIn = true
                    }
                } label: {
                    Image(systemName: "multiply.circle")
                        .font(.system(size: 32, weight: .regular))
                        .symbolVariant(.circle.fill)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color.white.opacity(0.8),
                            gameManager.mainColorSheme(color: .blue)
                        )
                }
                .offset(x: 10, y: -10)
            }
            .frame(width: 250)
            TextField("Email", text: $viewModel.email)
                .font(.system(size: 18, weight: .semibold))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .focused($showingKeyboard)
                .frame(width: 250, height: 28)
            Rectangle()
                .fill(viewModel.isEmailValid(_email: viewModel.email) ? .blue.opacity(0.6):.secondary)
                .frame(width: 250, height: 2)
            SecureField(NSLocalizedString("Password", comment: "Login view"), text: $viewModel.password)
                .font(.system(size: 18, weight: .semibold))
                .focused($showingKeyboard)
                .frame(width: 250, height: 28)
            Rectangle()
                .fill(!viewModel.password.isEmpty ? .blue.opacity(0.6):.secondary)
                .frame(width: 250, height: 2)
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        viewModel.loginView = .forgot
                    }
                } label: {
                    Text("forgot")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(.secondary)
                }
                
            }
            .frame(width: 250)
            
            Group {
                if !viewModel.email.isEmpty || !viewModel.password.isEmpty {
                    Button {
                        FBAuth.authenticate(withEmail: self.viewModel.email,
                                            password: self.viewModel.password) { (result) in
                            switch result {
                            case .failure(let error):
                                self.viewModel.authError = error
                                self.viewModel.showingLoginError = true
                            case .success( _):
                                print("Signed in")
                                viewModel.clearModel()
                            }
                        }
                        showingKeyboard = false
                    } label: {
                        Text("Login")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(viewModel.isLogInComplete ? .primary:.secondary)
                    }
                    .disabled(viewModel.isLogInComplete ? false:true)
                } else {
                    Button {
                        withAnimation {
                            viewModel.loginView = .signUp
                        }
                    } label: {
                        Text("Sign up")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
            SignInWithAppleButtonView()
            Text("Login, if you want to use the application's network features.")
                .frame(width: 250)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
        }
        .padding(32)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert(isPresented: $viewModel.showingLoginError) {
            Alert(title: Text("Login failed"), message: Text(self.viewModel.authError?.localizedDescription ?? "Unknown error."), dismissButton: .default(Text("OK")) {
                if self.viewModel.authError == .incorrectPassword {
                    self.viewModel.password = ""
                } else {
                    self.viewModel.password = ""
                    self.viewModel.email = ""
                }
            })
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: LoginViewModel())
            .preferredColorScheme(.light)
            .environmentObject(GameManager())
    }
}
