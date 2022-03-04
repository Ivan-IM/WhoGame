//
//  SignUpView.swift
//  CoachApp
//
//  Created by Иван Маришин on 21.11.2021.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack {
            VStack {
                TextField("User name", text: $viewModel.fullname)
                    .font(.system(size: 18, weight: .semibold))
                    .focused($showingKeyboard)
                    .frame(width: 250, height: 28)
                Rectangle()
                    .fill(!viewModel.fullname.isEmpty ? .blue.opacity(0.6):.secondary)
                    .frame(width: 250, height: 2)
                TextField("Email", text: $viewModel.email)
                    .font(.system(size: 18, weight: .semibold))
                    .focused($showingKeyboard)
                    .frame(width: 250, height: 28)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                Rectangle()
                    .fill(viewModel.isEmailValid(_email: viewModel.email) ? .blue.opacity(0.6):.secondary)
                    .frame(width: 250, height: 2)
                HStack {
                    SecureField(NSLocalizedString("Password", comment: "Login view"), text: $viewModel.password)
                        .font(.system(size: 18, weight: .semibold))
                        .focused($showingKeyboard)
                    if showingKeyboard {
                        Button {
                            viewModel.showingPasswordMessage.toggle()
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.secondary)
                        }
                    } else {}
                }
                .frame(width: 250, height: 28)
                Rectangle()
                    .fill(viewModel.isPasswordValid(_password: viewModel.password) ? .blue.opacity(0.6):.secondary)
                    .frame(width: 250, height: 2)
                SecureField(NSLocalizedString("Confirm password", comment: "Login view"), text: $viewModel.confirmPassword)
                    .font(.system(size: 18, weight: .semibold))
                    .focused($showingKeyboard)
                    .frame(width: 250, height: 28)
                Rectangle()
                    .fill(viewModel.passConfirm())
                    .frame(width: 250, height: 2)
            }
            Text("Password must be 8 characters containing at least one number and one Capital letter.")
                .frame(width: 250)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
            HStack {
                Button {
                    withAnimation {
                        showingKeyboard = false
                        viewModel.loginView = .signIn
                        viewModel.showingPasswordMessage = false
                    }
                } label: {
                    Text("Cancel")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.primary)
                }
                Spacer()
                Button {
                    FBAuth.createUser(withEmail: self.viewModel.email,
                                      name: self.viewModel.fullname,
                                      password: self.viewModel.password) { (result) in
                        switch result {
                        case .failure(let error):
                            self.viewModel.errorString = error.localizedDescription
                            self.viewModel.showingSignUpError = true
                        case .success( _):
                            print("Account creation successful")
                            viewModel.clearModel()
                        }
                    }
                    showingKeyboard = false
                    viewModel.showingPasswordMessage = false
                } label: {
                    Text("Register")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(viewModel.isSignInComplete ? .primary:.secondary)
                }
                .disabled(viewModel.isSignInComplete ? false:true)
            }
            .frame(width: 250)
            .padding(.top, 10)
            
        }
        .padding(32)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert(isPresented: $viewModel.showingSignUpError) {
            Alert(title: Text("Account creation error"), message: Text(self.viewModel.errorString ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: LoginViewModel())
            .preferredColorScheme(.light)
            .environmentObject(GameManager())
    }
}
