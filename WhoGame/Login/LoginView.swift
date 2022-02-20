//
//  LoginView.swift
//  CoachApp
//
//  Created by Иван Маришин on 18.11.2021.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            switch viewModel.loginView {
            case .signIn:
                SignInView(viewModel: viewModel)
                    .transition(.move(edge: .leading))
                    .animation(.default, value: viewModel.loginView)
                    .zIndex(1)
            case .forgot:
                ForgotPasswordView(viewModel: viewModel)
                    .transition(.move(edge: .leading))
                    .animation(.default, value: viewModel.loginView)
                    .zIndex(2)
            case .signUp:
                SignUpView(viewModel: viewModel)
                    .transition(.move(edge: .leading))
                    .animation(.default, value: viewModel.loginView)
                    .zIndex(3)
            }
            VStack {
                Spacer()
                Button {
                    withAnimation {
                        gameManager.showingPrivacy = true
                    }
                } label: {
                    Text("Terms & Privacy")
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
            .preferredColorScheme(.light)
            .environmentObject(GameManager())
    }
}
