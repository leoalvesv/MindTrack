//
//  TelaConfiguracoesView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import SwiftData

struct ConfiguracoesView: View {
    
    @AppStorage("notificacoesAtivas") private var notificacoesAtivas: Bool = true
    
    @Environment(\.modelContext) private var contextoDeDados
    @Query(sort: \Crise.dataRegistro, order: .forward) private var listaCrises: [Crise]
    
    @State private var mostrarCompartilhar = false
    @State private var arquivoURL: URL?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Configurações")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            .linearGradient(colors: [Color.green, Color.mint],
                                            startPoint: .leading,
                                            endPoint: .trailing)
                        )
                        .padding(.top, 10)
                    
                    // Notificações
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Notificações")
                            .font(.headline)
                        Toggle(isOn: $notificacoesAtivas) {
                            Text(notificacoesAtivas ? "Ativas" : "Desativadas")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // Exportação de dados
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Exportar dados")
                            .font(.headline)
                        Button {
                            exportarCSV()
                        } label: {
                            Label("Exportar CSV", systemImage: "square.and.arrow.up")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.linearGradient(colors: [.mint, .green],
                                                            startPoint: .leading,
                                                            endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(radius: 4)
                        }
                        .buttonStyle(.plain)
                        .sheet(isPresented: $mostrarCompartilhar, content: {
                            if let arquivoURL {
                                ActivityViewController(activityItems: [arquivoURL])
                            }
                        })
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    Spacer(minLength: 30)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
    }
    
    // MARK: - Funções auxiliares
    
    private func exportarCSV() {
        var csvString = "Data,Intensidade,Sintomas,Gatilhos,Anotacoes\n"
        for crise in listaCrises {
            let data = crise.dataRegistro.formatted(date: .numeric, time: .shortened)
            let intensidade = crise.intensidadeDor
            let sintomas = crise.sintomasRegistrados.joined(separator: ";")
            let gatilhos = crise.gatilhosPossiveis.joined(separator: ";")
            let anotacoes = crise.anotacoesAdicionais?.replacingOccurrences(of: ",", with: ";") ?? ""
            csvString.append("\(data),\(intensidade),\(sintomas),\(gatilhos),\(anotacoes)\n")
        }
        
        do {
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("MindTrack_Historico.csv")
            try csvString.write(to: tempURL, atomically: true, encoding: .utf8)
            arquivoURL = tempURL
            mostrarCompartilhar = true
        } catch {
            print("Erro ao exportar CSV: \(error.localizedDescription)")
        }
    }
}
