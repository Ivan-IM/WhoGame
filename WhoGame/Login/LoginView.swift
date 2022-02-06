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
                    .transition(.offset(x: -gameManager.width))
                    .animation(.default, value: viewModel.loginView)
            case .forgot:
                ForgotPasswordView(viewModel: viewModel)
                    .transition(.offset(x: -gameManager.width))
                    .animation(.default, value: viewModel.loginView)
            case .signUp:
                SignUpView(viewModel: viewModel)
                    .transition(.offset(x: -gameManager.width))
                    .animation(.default, value: viewModel.loginView)
            }
//            SignInView(viewModel: viewModel)
//            SignUpView(viewModel: viewModel)
//                .offset(y: viewModel.showingSingUp ? 0:-height*0.7)
//                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: viewModel.showingSingUp)
//            ForgotPasswordView(viewModel: viewModel)
//                .offset(y: viewModel.showingForgotPassword ? 0:-height*0.7)
//                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: viewModel.showingForgotPassword)
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
