//
//  EstatisticasViewModel.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import Foundation
import SwiftData

@MainActor
class EstatisticasViewModel: ObservableObject {
    
    @Published var listaCrises: [Crise] = []
    
    func atualizarCrises(_ novasCrises: [Crise]) {
        listaCrises = novasCrises.sorted { $0.dataRegistro < $1.dataRegistro }
    }
    
    func intensidadeMedia() -> Double {
        guard !listaCrises.isEmpty else { return 0 }
        let total = listaCrises.reduce(0) { $0 + $1.intensidadeDor }
        return Double(total) / Double(listaCrises.count)
    }
    
    func sintomasMaisFrequentes() -> [(String, Int)] {
        var contagem: [String: Int] = [:]
        for crise in listaCrises {
            for sintoma in crise.sintomasRegistrados {
                contagem[sintoma, default: 0] += 1
            }
        }
        return contagem.sorted { $0.value > $1.value }
    }
    
    func gatilhosMaisFrequentes() -> [(String, Int)] {
        var contagem: [String: Int] = [:]
        for crise in listaCrises {
            for gatilho in crise.gatilhosPossiveis {
                contagem[gatilho, default: 0] += 1
            }
        }
        return contagem.sorted { $0.value > $1.value }
    }
}
