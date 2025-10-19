//
//  Crise.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import Foundation
import SwiftData

@Model
class Crise {
    
    var dataRegistro: Date
    var intensidadeDor: Int
    var anotacoesAdicionais: String?
    
    private var sintomasJSON: String
    private var gatilhosJSON: String
    
    var sintomasRegistrados: [String] {
        get { (try? JSONDecoder().decode([String].self, from: Data(sintomasJSON.utf8))) ?? [] }
        set { sintomasJSON = (try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)) ?? "[]" }
    }
    
    var gatilhosPossiveis: [String] {
        get { (try? JSONDecoder().decode([String].self, from: Data(gatilhosJSON.utf8))) ?? [] }
        set { gatilhosJSON = (try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)) ?? "[]" }
    }
    
    init(
        dataRegistro: Date = .now,
        intensidadeDor: Int,
        sintomasRegistrados: [String] = [],
        gatilhosPossiveis: [String] = [],
        anotacoesAdicionais: String? = nil
    ) {
        self.dataRegistro = dataRegistro
        self.intensidadeDor = intensidadeDor
        self.anotacoesAdicionais = anotacoesAdicionais
        self.sintomasJSON = (try? String(data: JSONEncoder().encode(sintomasRegistrados), encoding: .utf8)) ?? "[]"
        self.gatilhosJSON = (try? String(data: JSONEncoder().encode(gatilhosPossiveis), encoding: .utf8)) ?? "[]"
    }
}
