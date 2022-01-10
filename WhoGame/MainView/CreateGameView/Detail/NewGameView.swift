//
//  NewGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct NewGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    @FocusState private var showingKeyboard: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Name", text: $viewModel.name)
                .focused($showingKeyboard)
                .font(.system(size: 18, weight: .semibold))
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.name.isEmpty ? LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing):LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 2)
            TextField("Theme", text: $viewModel.theme)
                .focused($showingKeyboard)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.theme.isEmpty ? LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing):LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 2)
            HStack {
                Text("Date of creation")
                    .font(.system(size: 16, weight: .ultraLight))
                Spacer()
                Text("\(viewModel.date.longDate)")
                    .font(.system(size: 16, weight: .ultraLight))
            }
            HStack(spacing: 16) {
                Button {
                    viewModel.showScore.toggle()
                } label: {
                    HStack {
                        Text("Score")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(viewModel.showScore ? .primary:.secondary)
                        Group {
                            if viewModel.showScore {
                                Image(systemName: "bolt")
                                    .font(.system(size: 16, weight: .regular))
                                    .imageScale(.large)
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            } else {
                                Image(systemName: "bolt.slash")
                                    .font(.system(size: 16, weight: .regular))
                                    .imageScale(.large)
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                            
                        }
                    }
                }
                Button {
                    viewModel.showAnswer.toggle()
                } label: {
                    HStack {
                        Text("Answers")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(viewModel.showAnswer ? .primary:.secondary)
                        Group {
                            if viewModel.showAnswer {
                                Image(systemName: "eye")
                                    .font(.system(size: 16, weight: .regular))
                                    .imageScale(.large)
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        LinearGradient(colors: [Color.mint, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            } else {
                                Image(systemName: "eye.slash")
                                    .font(.system(size: 16, weight: .regular))
                                    .imageScale(.large)
                                    .symbolVariant(.circle.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(
                                        Color.white.opacity(0.8),
                                        LinearGradient(colors: [Color.red, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                            
                        }
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                Group {
                    if viewModel.editMode {
                        Button {
                            viewModel.updateGame()
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 32, weight: .regular))
                                .imageScale(.large)
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(viewModel.isValidForm() ? 0.0:0.8),
                                    LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                        .disabled(viewModel.isValidForm())
                    } else {
                        Button {
                            viewModel.saveNewGame()
                            showingKeyboard = false
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 32, weight: .regular))
                                .imageScale(.large)
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(viewModel.isValidForm() ? 0.0:0.8),
                                    LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                        .disabled(viewModel.isValidForm())
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

struct NewGameView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameView(viewModel: CreateGameViewModel())
    }
}
