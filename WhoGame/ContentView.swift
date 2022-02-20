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
            Group {
                if viewModel.isUserAuthenticated == .undefined {
                    Text("Loading...")
                }
                else if viewModel.isUserAuthenticated == .signedOut {
                    LoginView(viewModel: viewModel)
                }
                else {
                    MainView()
                        .onAppear {
                            fbManager.getFBData()
                        }
                }
            }
            if gameManager.showingPrivacy {
                TermsPrivacyView()
                    .transition(.move(edge: .bottom))
                    .animation(.default, value: gameManager.showingPrivacy)
                    .zIndex(1)
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
