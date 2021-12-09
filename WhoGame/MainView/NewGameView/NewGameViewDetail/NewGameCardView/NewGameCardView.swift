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
    
    let width: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gameManager.mainColor)
                        .frame(width: 70, height: 70)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .fill(gameManager.mainColor)
                        .frame(width: 70, height: 70)
                }
            }
            VStack {
                HStack {
                    Button {
                            viewModel.showMarkMenu = true
                    } label: {
                        Image(systemName: "\(viewModel.mark).circle")
                            .font(.title.bold())
                            .foregroundColor(.primary)
                            .blendMode(.overlay)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    TextField("Question", text: $viewModel.question)
                        .font(.title2)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    TextField("Answer", text: $viewModel.answer)
                        .font(.title2)
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Spacer()
                    Button {
                        viewModel.saveNewGameCard()
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
            .frame(width: width*0.9, height: 210)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            Group {
                if viewModel.showMarkMenu {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], spacing: 14) {
                            ForEach(viewModel.markArray, id: \.self) { number in
                                Button {
                                    viewModel.mark = number
                                    viewModel.showMarkMenu = false
                                } label: {
                                    Image(systemName: "\(number).circle")
                                        .font(.title.bold())
                                        .foregroundColor(.secondary)
                                }
                                
                            }
                        }
                    }
                    .padding()
                    .frame(width: width*0.9, height: 210)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut, value: viewModel.showMarkMenu)
        }
        .frame(width: width*0.9, height: 210)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(gameManager.mainColor, lineWidth: 5)
                .frame(width: width*0.9-6, height: 204)
        )
    }
}

struct NewGameCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameCardView(viewModel: NewGameCardViewModel(showingNewCard: .constant(true), gameId: ""), width: UIScreen.main.bounds.size.width)
            .environmentObject(GameManager())
    }
}
