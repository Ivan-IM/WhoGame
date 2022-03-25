//
//  ContentView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var fbManager: FBManager
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            Group {
                if gameManager.skipSignIn {
                    MainView()
                } else {
                    if viewModel.isUserAuthenticated == .undefined {
                        Text("Loading...")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    else if viewModel.isUserAuthenticated == .signedOut {
                        LoginView(viewModel: viewModel)
                            .transition(.move(edge: .leading))
                            .animation(.default, value: viewModel.isUserAuthenticated)
                            .zIndex(1)
                    }
                    else {
                        MainView()
                            .onAppear {
                                fbManager.getFBData()
                            }
                    }
                }
            }
            if gameManager.showingPrivacy {
                TermsPrivacyView()
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: gameManager.showingPrivacy)
                    .zIndex(2)
            }
            if gameManager.firstEnter {
                OnboardingView()
                    .transition(.move(edge: .leading))
                    .animation(.default, value: gameManager.firstEnter)
                    .zIndex(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameManager())
            .environmentObject(FBManager())
    }
}
