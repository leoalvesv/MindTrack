//
//  TelaPrincipalView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import SwiftData

struct TelaPrincipalView: View {
    
    @Environment(\.modelContext) private var contextoDeDados
    
    var body: some View {
        TabView {
            
            // Aba Histórico de Crises
            HistoricoCrisesView()
                .tabItem {
                    Label("Histórico", systemImage: "list.bullet")
                }
            
            // Aba Registrar nova crise
            NovaCriseView()
                .tabItem {
                    Label("Nova Crise", systemImage: "plus.circle.fill")
                }
            
            // Aba Estatísticas
            EstatisticasView()
                .tabItem {
                    Label("Estatísticas", systemImage: "chart.bar.fill")
                }
            
            // Aba Configurações
            ConfiguracoesView()
                .tabItem {
                    Label("Configurações", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.green)
    }
}
