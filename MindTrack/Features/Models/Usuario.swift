//
//  Usuario.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import Foundation
import SwiftData

@Model
class Usuario {
    
    var nomeCompleto: String
    var email: String
    var dataNascimento: Date?
    var genero: String?
    var dataCriacao: Date
    
    init(
        nomeCompleto: String,
        email: String,
        dataNascimento: Date? = nil,
        genero: String? = nil,
        dataCriacao: Date = .now
    ) {
        self.nomeCompleto = nomeCompleto
        self.email = email
        self.dataNascimento = dataNascimento
        self.genero = genero
        self.dataCriacao = dataCriacao
    }
}
