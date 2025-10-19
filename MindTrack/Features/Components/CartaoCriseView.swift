//
//  CartaoCriseView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI

struct CartaoCriseView: View {
    
    var crise: Crise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(crise.dataRegistro.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("Intensidade: \(crise.intensidadeDor)/10")
                    .bold()
                    .foregroundColor(.green)
            }
            
            if !crise.sintomasRegistrados.isEmpty {
                Text("Sintomas: \(crise.sintomasRegistrados.joined(separator: ", "))")
                    .font(.subheadline)
            }
            
            if !crise.gatilhosPossiveis.isEmpty {
                Text("Gatilhos: \(crise.gatilhosPossiveis.joined(separator: ", "))")
                    .font(.subheadline)
            }
            
            if let anotacoes = crise.anotacoesAdicionais, !anotacoes.isEmpty {
                Text("Anotações: \(anotacoes)")
                    .font(.subheadline)
                    .italic()
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
