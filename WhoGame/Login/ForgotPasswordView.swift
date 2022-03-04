//
//  ForgotPasswordView.swift
//  CoachApp
//
//  Created by Иван Маришин on 22.11.2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .font(.system(size: 18, weight: .semibold))
                .focused($showingKeyboard)
                .frame(width: 250, height: 28)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            Rectangle()
                .fill(viewModel.isEmailValid(_email: viewModel.email) ? .blue.opacity(0.6):.secondary)
                .frame(width: 250, height: 2)
            Text("To reset your password, please enter your email.")
                .frame(width: 250)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
            HStack {
                Button {
                    withAnimation {
                        viewModel.loginView = .signIn
                    }
                } label: {
                    Text("Cancel")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.primary)
                }
                Spacer()
                Button {
                    FBAuth.resetPassword(email: self.viewModel.email) { (result) in
                        switch result {
                        case .failure(let error):
                            self.viewModel.errorString = error.localizedDescription
                        case .success( _):
                            self.viewModel.showingForgotAlert = true
                        }
                    }
                } label: {
                    Text("Reset")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(viewModel.isEmailValid(_email: viewModel.email) ? .primary:.secondary)
                }
                .disabled(viewModel.isEmailValid(_email: viewModel.email) ? false:true)
                
            }
            .frame(width: 250)
            .padding(.top, 10)
        }
        .padding(32)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
        .alert(isPresented: $viewModel.showingForgotAlert) {
            Alert(title: Text(NSLocalizedString("Request a password reset", comment: "")), message: Text(self.viewModel.errorString ?? NSLocalizedString("Success. Check your email.", comment: "")), dismissButton: .default(Text("OK")) {
                withAnimation {
                    viewModel.clearModel()
                }
            })
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(viewModel: LoginViewModel())
            .preferredColorScheme(.light)
            .environmentObject(GameManager())
    }
}
