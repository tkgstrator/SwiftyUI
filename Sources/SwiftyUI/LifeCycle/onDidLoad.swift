//
//  onDidLoad.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

struct ViewDidLoadHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewDidLoadHandler.Coordinator {
        Coordinator(onDidLoad: onDidLoad)
    }
    
    let onDidLoad: () -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewDidLoadHandler>) -> some UIViewController {
        context.coordinator
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    class Coordinator: UIViewController {
        let onDidLoad: () -> Void
        
        init(onDidLoad: @escaping () -> Void) {
            self.onDidLoad = onDidLoad
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            onDidLoad()
        }
    }
}

struct ViewDidLoadModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewDidLoadHandler(onDidLoad: callback))
    }
}

public extension View {
    /// Run at the same time viewDidLoad()
    func onDidLoad(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewDidLoadModifier(callback: perform))
    }
}
