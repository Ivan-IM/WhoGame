//
//  MainView.swift
//  WhoGame
//
//  Created by Иван Маришин on 05.12.2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("New Game")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
