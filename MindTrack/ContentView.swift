//
//  ContentView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI

struct ContentView: View {
    
    @State private var mostrarTelaPrincipal = false
    
    var body: some View {
        if mostrarTelaPrincipal {
            TelaPrincipalView()
        } else {
            SplashView(mostrarTelaPrincipal: $mostrarTelaPrincipal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
