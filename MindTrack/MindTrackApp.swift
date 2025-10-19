//
//  MindTrackApp.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//

import SwiftUI
import SwiftData

@main
struct MindTrackApp: App {
    
    // Criar o container principal do SwiftData
    let containerDeDados: ModelContainer = {
        do {
            return try ModelContainer(for: Crise.self)
        } catch {
            fatalError("Erro ao inicializar o SwiftData: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(containerDeDados)
        }
    }
}
