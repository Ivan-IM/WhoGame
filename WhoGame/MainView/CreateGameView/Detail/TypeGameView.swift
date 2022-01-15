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
                                .padding(.trailing, 16)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                Button {
                    viewModel.type = 1
                } label: {
                    HStack {
                        Image(systemName: "2")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: viewModel.type == 1 ? .green:.red)
                        )
                        if viewModel.type == 1 {
                            Text("Test (2 answers)")
                                .font(.system(size: 22, weight: .semibold))
                                .padding(.trailing, 16)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                Button {
                    viewModel.type = 2
                } label: {
                    HStack {
                        Image(systemName: "4")
                            .font(.system(size: 44, weight: .regular))
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(
                                Color.white.opacity(0.8),
                                gameManager.mainColorSheme(color: viewModel.type == 2 ? .green:.red)
                        )
                        if viewModel.type == 2 {
                            Text("Test (4 answers)")
                                .font(.system(size: 22, weight: .semibold))
                                .padding(.trailing, 16)
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
                                .padding(.trailing, 16)
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
            Spacer()
        }
    }
}
