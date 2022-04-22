//
//  onWillDisappear.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

struct ViewWillDisappearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> ViewWillDisappearHandler.Coordinator {
        Coordinator(onWillDisappear: onWillDisappear)
    }

    let onWillDisappear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewWillDisappearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewWillDisappearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

struct ViewWillDisappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewWillDisappearHandler(onWillDisappear: callback))
    }
}

public extension View {
    /// Run at the same time viewWillDisapper()
    func onWillDisappear(perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewWillDisappearModifier(callback: perform))
    }
}
