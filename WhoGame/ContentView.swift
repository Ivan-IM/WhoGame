//
//  ContentView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameManager())
    }
}
