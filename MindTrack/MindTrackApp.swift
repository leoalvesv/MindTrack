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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Crise.self, Usuario.self])
        }
    }
}
