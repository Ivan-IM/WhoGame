//
//  SaveGameView.swift
//  WhoGame
//
//  Created by Иван Маришин on 07.01.2022.
//

import SwiftUI

struct SaveGameView: View {
    
    @ObservedObject var viewModel: CreateGameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.name)
                .font(.system(size: 18, weight: .semibold))
            Text("Theme: \(viewModel.theme)")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondary)
            HStack {
                Text("Date of creation")
                    .font(.system(size: 16, weight: .ultraLight))
                Spacer()
                Text("\(viewModel.date.longDate)")
                    .font(.system(size: 16, weight: .ultraLight))
            }
            HStack(spacing: 16) {
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
                Spacer()
            }
            HStack {
                Spacer()
                Group {
                    if !viewModel.editMode {
                        Button {
                            viewModel.editMode = true
                        } label: {
                            Image(systemName: "pencil")
                                .font(.system(size: 32, weight: .regular))
                                .imageScale(.large)
                                .symbolVariant(.circle.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(
                                    Color.white.opacity(viewModel.isValidForm() ? 0.0:0.8),
                                    LinearGradient(colors: [Color.teal, Color.blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32))
    }
}

struct SaveGameView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            SaveGameView(viewModel: CreateGameViewModel())
        }
    }
}
