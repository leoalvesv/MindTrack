//
//  ActivityViewController.swift
//  MindTrack
//
//  Created by Leonardo Alves Viana on 18/10/25.
//


import SwiftUI
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
