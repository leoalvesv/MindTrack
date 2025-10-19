//
//  BotaoSelecaoItem.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI

struct BotaoSelecaoItem: View {
    
    var tituloItem: String
    var estaSelecionado: Bool
    var acaoBotao: () -> Void
    
    var body: some View {
        Button(action: acaoBotao) {
            HStack {
                Text(tituloItem)
                    .font(.body)
                    .foregroundColor(.primary)
                Spacer()
                if estaSelecionado {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .symbolEffect(.bounce)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

