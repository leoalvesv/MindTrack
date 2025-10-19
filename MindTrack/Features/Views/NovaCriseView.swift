//
//  NovaCriseView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import SwiftData

struct NovaCriseView: View {
    
    // MARK: - Ambientes e estados
    @Environment(\.dismiss) private var fecharTela
    @Environment(\.modelContext) private var contextoDeDados
    
    @State private var intensidadeDor: Double = 5
    @State private var sintomasSelecionados: [String] = []
    @State private var gatilhosSelecionados: [String] = []
    @State private var anotacoesAdicionais: String = ""
    @State private var dataCrise: Date = .now
    
    // Alerta
    @State private var mostrarAlerta = false
    @State private var mensagemAlerta = ""
    
    // Listas de opções
    private let sintomasDisponiveis = [
        "Sensibilidade à luz",
        "Sensibilidade ao som",
        "Náusea",
        "Tontura",
        "Visão turva",
        "Aura visual"
    ]
    
    private let gatilhosDisponiveis = [
        "Falta de sono",
        "Estresse",
        "Luz forte",
        "Cheiro forte",
        "Fome",
        "Mudança de clima"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // Título
                    Text("Registrar nova crise")
                        .font(.title.bold())
                        .foregroundStyle(
                            .linearGradient(colors: [.green, .mint],
                                            startPoint: .leading,
                                            endPoint: .trailing)
                        )
                        .padding(.top, 10)
                    
                    // MARK: - Data da crise
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Data da crise")
                            .font(.headline)
                        
                        DatePicker(
                            "Selecione a data",
                            selection: $dataCrise,
                            in: ...Date(), // somente datas passadas e hoje
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // MARK: - Intensidade da dor
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Intensidade da dor")
                            .font(.headline)
                        
                        Slider(value: $intensidadeDor, in: 0...10, step: 1)
                            .tint(.green)
                        
                        Text("Nível atual: \(Int(intensidadeDor)) / 10")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // MARK: - Sintomas
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sintomas sentidos")
                            .font(.headline)
                        
                        ForEach(sintomasDisponiveis, id: \.self) { sintoma in
                            BotaoSelecaoItem(
                                tituloItem: sintoma,
                                estaSelecionado: sintomasSelecionados.contains(sintoma)
                            ) {
                                alternarSelecaoItem(item: sintoma, listaSelecionada: &sintomasSelecionados)
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // MARK: - Gatilhos
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Possíveis gatilhos")
                            .font(.headline)
                        
                        ForEach(gatilhosDisponiveis, id: \.self) { gatilho in
                            BotaoSelecaoItem(
                                tituloItem: gatilho,
                                estaSelecionado: gatilhosSelecionados.contains(gatilho)
                            ) {
                                alternarSelecaoItem(item: gatilho, listaSelecionada: &gatilhosSelecionados)
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // MARK: - Anotações adicionais
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Anotações adicionais")
                            .font(.headline)
                        
                        TextEditor(text: $anotacoesAdicionais)
                            .frame(height: 120)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // MARK: - Botão de salvar
                    Button {
                        salvarNovaCrise()
                    } label: {
                        Label("Salvar crise", systemImage: "checkmark.circle.fill")
                            .font(.title3.bold())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                .linearGradient(colors: [.green, .mint],
                                                startPoint: .leading,
                                                endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 4)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.plain)
                    .symbolEffect(.bounce)
                }
                .padding()
            }
        }
        .alert(mensagemAlerta, isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) {
                if mensagemAlerta.contains("sucesso") {
                    resetarFormulario()
                    fecharTela()
                }
            }
        }
    }
    
    // MARK: - Métodos auxiliares
    private func alternarSelecaoItem(item: String, listaSelecionada: inout [String]) {
        if let indice = listaSelecionada.firstIndex(of: item) {
            listaSelecionada.remove(at: indice)
        } else {
            listaSelecionada.append(item)
        }
    }
    
    private func salvarNovaCrise() {
        let novaCrise = Crise(
            dataRegistro: dataCrise,
            intensidadeDor: Int(intensidadeDor),
            sintomasRegistrados: sintomasSelecionados,
            gatilhosPossiveis: gatilhosSelecionados,
            anotacoesAdicionais: anotacoesAdicionais
        )
        
        contextoDeDados.insert(novaCrise)
        
        do {
            try contextoDeDados.save()
            mensagemAlerta = "Crise salva com sucesso!"
        } catch {
            mensagemAlerta = "Erro ao salvar a crise: \(error.localizedDescription)"
        }
        
        mostrarAlerta = true
    }
    
    private func resetarFormulario() {
        intensidadeDor = 5
        sintomasSelecionados = []
        gatilhosSelecionados = []
        anotacoesAdicionais = ""
        dataCrise = .now
    }
}
