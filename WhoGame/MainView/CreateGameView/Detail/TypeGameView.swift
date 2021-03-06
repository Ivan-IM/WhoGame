//
//  TypeGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 13.01.2022.
//

import SwiftUI

struct TypeGameView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    viewModel.type = 0
                } label: {
                    HStack {
                        Image(systemName: "message")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: viewModel.type == 0 ? .green:.red)
                            )
                        if viewModel.type == 0 {
                            Text("Classic")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.trailing, 16)
                                .transition(.opacity)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                Button {
                    viewModel.type = 2
                } label: {
                    HStack {
                        Image(systemName: "hand.raised")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: viewModel.type == 1 || viewModel.type == 2 ? .green:.red)
                            )
                        if viewModel.type == 1 || viewModel.type == 2 {
                            Text("Test")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.trailing, 16)
                                .transition(.opacity)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                Button {
                    viewModel.type = 3
                } label: {
                    HStack {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: viewModel.type == 3 ? .green:.red)
                            )
                        if viewModel.type == 3 {
                            Text("Blind tasting")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.trailing, 16)
                                .transition(.opacity)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
            .animation(.default, value: viewModel.type)
            Spacer()
        }
    }
}
