//
//  SplashView.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI

struct SplashView: View {
    
    @Binding var mostrarTelaPrincipal: Bool
    @State private var animacaoEscala: CGFloat = 0.6
    @State private var animacaoOpacidade: Double = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.green.opacity(0.7), Color.mint.opacity(0.7)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "brain.head.profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .scaleEffect(animacaoEscala)
                    .opacity(animacaoOpacidade)
                
                Text("MindTrack")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(animacaoOpacidade)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animacaoEscala = 1.0
                animacaoOpacidade = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                mostrarTelaPrincipal = true
            }
        }
    }
}
