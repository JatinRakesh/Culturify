//
//  ARViewControllerWrapper.swift
//  ARTest
//
//  Created by Bryan Nguyen on 20/3/25.
//
import SwiftUI
import UIKit

struct ARViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()  
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
      
    }
}

struct RPandMandarinWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RPMViewController {
        return RPMViewController() 
    }
    
    func updateUIViewController(_ uiViewController: RPMViewController, context: Context) {
        
    }
}

struct LionDanceWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LionDanceView {
        return LionDanceView()
    }
    
    func updateUIViewController(_ uiViewController: LionDanceView, context: Context) {
    }
}
