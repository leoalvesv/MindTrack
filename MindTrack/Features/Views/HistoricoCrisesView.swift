//
//  HistoricoCrisesView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import SwiftData

struct HistoricoCrisesView: View {
    
    @Environment(\.modelContext) private var contextoDeDados
    @Query(sort: \Crise.dataRegistro, order: .reverse) private var listaCrises: [Crise]
    
    @State private var filtroIntensidadeMin: Double = 0
    @State private var filtroIntensidadeMax: Double = 10
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Histórico de Crises")
                    .font(.largeTitle.bold())
                    .foregroundStyle(
                        .linearGradient(colors: [.green, .mint],
                                        startPoint: .leading,
                                        endPoint: .trailing)
                    )
                    .padding(.top, 10)
                
                // Filtros de intensidade
                VStack {
                    Text("Filtrar por intensidade da dor")
                        .font(.headline)
                    HStack {
                        Text("\(Int(filtroIntensidadeMin))")
                        Slider(value: $filtroIntensidadeMin, in: 0...filtroIntensidadeMax, step: 1)
                        Text("\(Int(filtroIntensidadeMax))")
                    }
                    .padding(.horizontal)
                }
                
                // Lista de crises filtradas
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(listaCrises.filter { Double($0.intensidadeDor) >= filtroIntensidadeMin &&
                                                     Double($0.intensidadeDor) <= filtroIntensidadeMax }) { crise in
                            CartaoCriseView(crise: crise)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.spring(), value: listaCrises)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}
