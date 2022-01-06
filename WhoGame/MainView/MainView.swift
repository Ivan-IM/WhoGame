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
                    CreateGameView()
                } label: {
                    Text("Create game")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
                NavigationLink {
                    
                } label: {
                    Text("Play game")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
