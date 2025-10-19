//
//  PerfilUsuarioView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI
import SwiftData

struct PerfilUsuarioView: View {
    
    @Environment(\.modelContext) private var contextoDeDados
    @StateObject private var viewModel: UsuarioViewModel

    init(contexto: ModelContext) {
        _viewModel = StateObject(wrappedValue: UsuarioViewModel(contexto: contexto))
    }

    @State private var nomeCompleto: String = ""
    @State private var email: String = ""
    @State private var dataNascimento: Date = .now
    @State private var genero: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Perfil do Usuário")
                .font(.largeTitle.bold())
                .foregroundStyle(.linearGradient(colors: [Color.green, Color.mint],
                                                 startPoint: .leading,
                                                 endPoint: .trailing))
            
            TextField("Nome completo", text: $nomeCompleto)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("Data de nascimento", selection: $dataNascimento, displayedComponents: .date)
                .datePickerStyle(.compact)
            
            TextField("Gênero", text: $genero)
                .textFieldStyle(.roundedBorder)
            
            Button("Salvar") {
                if viewModel.usuarioAtual == nil {
                    viewModel.criarUsuario(nomeCompleto: nomeCompleto,
                                           email: email,
                                           dataNascimento: dataNascimento,
                                           genero: genero)
                } else {
                    viewModel.atualizarUsuario(nomeCompleto: nomeCompleto,
                                               email: email,
                                               dataNascimento: dataNascimento,
                                               genero: genero)
                }
            }
            .padding()
            .background(.linearGradient(colors: [Color.mint, Color.green], startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.carregarUsuario()
            if let usuario = viewModel.usuarioAtual {
                nomeCompleto = usuario.nomeCompleto
                email = usuario.email
                dataNascimento = usuario.dataNascimento ?? .now
                genero = usuario.genero ?? ""
            }
        }
    }
}
