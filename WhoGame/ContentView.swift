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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameManager())
            .environmentObject(FBManager())
    }
}
