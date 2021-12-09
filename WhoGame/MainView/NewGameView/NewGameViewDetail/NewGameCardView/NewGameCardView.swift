//
//  NewGameCardView.swift
//  WhoGame
//
//  Created by Иван Маришин on 09.12.2021.
//

import SwiftUI

struct NewGameCardView: View {
    
    @ObservedObject var viewModel: NewGameCardViewModel
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 16)
                .fill(gameManager.mainColor)
                .frame(width: 70, height: 70)
            VStack {
                Spacer()
                HStack {
                    Text("Mark")
                }
                HStack {
                    TextField("Question", text: $viewModel.question)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    TextField("Answer", text: $viewModel.answer)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                    .padding(.top, 8)

                }
            }
            .padding()
            .frame(width: 280, height: 200)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
        .frame(width: 280, height: 280)
    }
}

struct NewGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameCardView(viewModel: NewGameCardViewModel())
            .environmentObject(GameManager())
    }
}
