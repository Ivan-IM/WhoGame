//
//  EndStageTastyView.swift
//  WhoGame
//
//  Created by Иван Маришин on 15.01.2022.
//

import SwiftUI

struct EndStageTastyView: View {
    
    @EnvironmentObject var gameManager: GameManager
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.gameCards) { card in
                    HStack {
                        switch card.mark {
                        case 1:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        case 2:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white, .gray, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        case 3:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(0.8),
                                    LinearGradient(colors: [.white,.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        default:
                            Image(systemName: "\(card.mark)")
                                .font(.system(size: 44, weight: .regular))
                                .symbolVariant(.circle)
                                .symbolRenderingMode(.palette)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                        Text("\(card.answer ?? "Unknown")")
                            .lineLimit(1)
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.primary)
                    .padding()
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
                }
            }
            Button {
                viewModel.clearGame()
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 88, weight: .regular))
                    .symbolVariant(.circle.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        Color.white.opacity(0.8),
                        gameManager.mainColorSheme(color: .green)
                    )
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
            }
        }
    }
}
