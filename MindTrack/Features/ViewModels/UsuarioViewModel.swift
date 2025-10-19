//
//  UsuarioViewModel.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import Foundation
import SwiftData

@MainActor
class UsuarioViewModel: ObservableObject {
    
    @Published var usuarioAtual: Usuario?
    private var contextoDeDados: ModelContext
    
    init(contexto: ModelContext) {
        self.contextoDeDados = contexto
    }
    
    func criarUsuario(nomeCompleto: String, email: String, dataNascimento: Date? = nil, genero: String? = nil) {
        let novoUsuario = Usuario(nomeCompleto: nomeCompleto,
                                  email: email,
                                  dataNascimento: dataNascimento,
                                  genero: genero)
        contextoDeDados.insert(novoUsuario)
        try? contextoDeDados.save()
        usuarioAtual = novoUsuario
    }
    
    func atualizarUsuario(nomeCompleto: String, email: String, dataNascimento: Date?, genero: String?) {
        guard let usuario = usuarioAtual else { return }
        usuario.nomeCompleto = nomeCompleto
        usuario.email = email
        usuario.dataNascimento = dataNascimento
        usuario.genero = genero
        try? contextoDeDados.save()
    }
    
    func carregarUsuario() {
        let requisicao: FetchDescriptor<Usuario> = FetchDescriptor(sortBy: [SortDescriptor(\.dataCriacao)])
        if let primeiroUsuario = try? contextoDeDados.fetch(requisicao).first {
            usuarioAtual = primeiroUsuario
        }
    }
}

