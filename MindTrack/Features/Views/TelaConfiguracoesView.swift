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
    @Query(sort: \Crise.dataRegistro, order: .reverse) private var listaCrises: [Crise]
    
    // Exportação
    @State private var mostrarResumoExportacao = false
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
                    
                    // MARK: - Notificações
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
                    
                    // MARK: - Exportar dados
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Exportar dados")
                            .font(.headline)
                        
                        Button {
                            mostrarResumoExportacao = true
                        } label: {
                            Label("Visualizar e Exportar", systemImage: "square.and.arrow.up")
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
                        .sheet(isPresented: $mostrarResumoExportacao) {
                            ResumoExportacaoView(listaCrises: listaCrises)
                        }
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
}

// MARK: - Tela de Resumo de Exportação

struct ResumoExportacaoView: View {
    
    var listaCrises: [Crise]
    @Environment(\.dismiss) private var fecharTela
    @State private var mostrarAlertaCompartilhar = false
    @State private var arquivoURL: URL?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Resumo das Crises")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(listaCrises) { crise in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(crise.dataRegistro.formatted(date: .numeric, time: .shortened))
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Intensidade: \(crise.intensidadeDor)/10")
                                    .bold()
                                    .foregroundColor(.green)
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
                            .frame(maxWidth: .infinity, alignment: .leading) // <- força largura igual
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                            .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Botão Exportar CSV
                Button {
                    exportarCSV()
                } label: {
                    Label("Exportar resumo", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.linearGradient(colors: [.green, .mint],
                                                    startPoint: .leading,
                                                    endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(radius: 4)
                        .padding()
                }
            }
            .navigationBarTitle("Resumo", displayMode: .inline)
            .alert("Erro ao exportar CSV", isPresented: $mostrarAlertaCompartilhar) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
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
            mostrarAlertaCompartilhar = true
            
            // Compartilhar
            if let arquivoURL {
                let activityVC = UIActivityViewController(activityItems: [arquivoURL], applicationActivities: nil)
                
                // Obter a cena ativa
                if let cena = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootController = cena.windows.first?.rootViewController {
                    rootController.present(activityVC, animated: true)
                }
            }
        } catch {
            mostrarAlertaCompartilhar = true
        }
    }
}
