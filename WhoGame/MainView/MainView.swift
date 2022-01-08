//
//  MainView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                NavigationLink {
                    CreateGameView(viewModel: CreateGameViewModel())
                } label: {
                    Text("Create")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
                NavigationLink {
                    GameListView()
                } label: {
                    Text("List")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
