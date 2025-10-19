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
    
    // MARK: - Filtros
    @State private var filtroIntensidadeMin: Double = 0
    @State private var filtroIntensidadeMax: Double = 10
    @State private var dataInicial: Date = Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now
    @State private var dataFinal: Date = .now
    
    // MARK: - Crises filtradas
    private var listaCrisesFiltradas: [Crise] {
        listaCrises.filter { crise in
            Double(crise.intensidadeDor) >= filtroIntensidadeMin &&
            Double(crise.intensidadeDor) <= filtroIntensidadeMax &&
            crise.dataRegistro >= dataInicial &&
            crise.dataRegistro <= dataFinal
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Histórico de Crises")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.linearGradient(colors: [.green, .mint],
                                                    startPoint: .leading,
                                                    endPoint: .trailing))
                    .padding(.top, 10)
                
                // MARK: - Filtro por intensidade
                VStack(spacing: 10) {
                    Text("Filtrar por intensidade da dor")
                        .font(.headline)
                    
                    HStack {
                        Text("\(Int(filtroIntensidadeMin))")
                        Slider(value: $filtroIntensidadeMin, in: 0...filtroIntensidadeMax, step: 1)
                            .tint(.green)
                        Text("\(Int(filtroIntensidadeMax))")
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 2)
                
                // MARK: - Filtro por período
                VStack(spacing: 10) {
                    Text("Filtrar por período")
                        .font(.headline)
                    
                    DatePicker("Data inicial", selection: $dataInicial, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    DatePicker("Data final", selection: $dataFinal, displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 2)
                
                // MARK: - Lista de crises filtradas
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(listaCrisesFiltradas) { crise in
                            CartaoCriseView(crise: crise)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.spring(), value: listaCrisesFiltradas)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}
