//
//  EstatisticasView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import Charts
import SwiftData

struct EstatisticasView: View {
    
    @StateObject private var viewModel = EstatisticasViewModel()
    @Environment(\.modelContext) private var contextoDeDados
    @Query(sort: \Crise.dataRegistro, order: .forward) private var listaCrises: [Crise]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Título
                    Text("Estatísticas das Crises")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            .linearGradient(colors: [.green, .mint],
                                            startPoint: .leading,
                                            endPoint: .trailing)
                        )
                        .padding(.top, 10)
                    
                    // Gráfico: Intensidade ao longo do tempo
                    if !viewModel.listaCrises.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Intensidade da dor")
                                .font(.headline)
                                .padding(.leading)
                            
                            Chart(viewModel.listaCrises) { crise in
                                LineMark(
                                    x: .value("Data", crise.dataRegistro),
                                    y: .value("Intensidade", crise.intensidadeDor)
                                )
                                .foregroundStyle(.green.gradient)
                                .interpolationMethod(.catmullRom)
                                
                                PointMark(
                                    x: .value("Data", crise.dataRegistro),
                                    y: .value("Intensidade", crise.intensidadeDor)
                                )
                                .foregroundStyle(.blue)
                            }
                            .frame(height: 250)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                    } else {
                        Text("Nenhuma crise registrada ainda para mostrar gráficos 📊")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                    
                    // Gráfico: Sintomas mais frequentes
                    if !viewModel.listaCrises.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Sintomas mais frequentes")
                                .font(.headline)
                                .padding(.leading)
                            
                            Chart(viewModel.sintomasMaisFrequentes(), id: \.0) { sintoma, quantidade in
                                BarMark(
                                    x: .value("Sintoma", sintoma),
                                    y: .value("Frequência", quantidade)
                                )
                                .foregroundStyle(.blue.gradient)
                            }
                            .frame(height: 200)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                    }
                    
                    // Gráfico: Gatilhos mais frequentes (opcional)
                    if !viewModel.listaCrises.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Gatilhos mais frequentes")
                                .font(.headline)
                                .padding(.leading)
                            
                            Chart(viewModel.gatilhosMaisFrequentes(), id: \.0) { gatilho, quantidade in
                                BarMark(
                                    x: .value("Gatilho", gatilho),
                                    y: .value("Frequência", quantidade)
                                )
                                .foregroundStyle(.purple.gradient)
                            }
                            .frame(height: 200)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                    }
                    
                    Spacer(minLength: 30)
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            viewModel.atualizarCrises(listaCrises)
        }
        .onChange(of: listaCrises) {
            viewModel.atualizarCrises(listaCrises)
        }
    }
}

struct EstatisticasView_Previews: PreviewProvider {
    static var previews: some View {
        EstatisticasView()
    }
}

