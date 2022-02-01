//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2022/01/29.
//

import SwiftUI

public extension View {
    func halfsheet<Content: View>(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> (),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .background(
                HalfModalSheet(
                    isPresented: isPresented,
                    onDismiss: onDismiss,
                    content: content
                )
            )
    }
}

struct HalfModalSheet<Content>: UIViewControllerRepresentable where Content: View {
    let content: () -> Content
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    let onDismiss: () -> Void
    
    init(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> CustomHostingController<Content> {
        return CustomHostingController(coordinator: context.coordinator, preferredColorScheme: colorScheme == .dark ? .dark : .light, content: content)
    }
    
    func updateUIViewController(
        _ viewController: CustomHostingController<Content>,
        context: Context
    ) {
        context.coordinator.parent = self
        viewController.parent?.presentationController?.delegate = context.coordinator
        viewController.hosting.sheetPresentationController?.detents = [.medium()]
        viewController.hosting.sheetPresentationController?.prefersGrabberVisible = true
        switch isPresented {
            case true:
                viewController.present()
            case false:
                viewController.dismiss()
        }
    }
    
    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfModalSheet
        
        init(_ parent: HalfModalSheet) {
            self.parent = parent
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
    }
    
    final class CustomHostingController<Content: View>: UIViewController {
        var content: Content
        let coordinator: HalfModalSheet<Content>.Coordinator
        let hosting: UIHostingController<Content>
        
        init(coordinator: HalfModalSheet<Content>.Coordinator,
             preferredColorScheme: UIUserInterfaceStyle,
             @ViewBuilder content: @escaping () -> Content
        ) {
            self.coordinator = coordinator
            self.content = content()
            self.hosting = UIHostingController(rootView: content())
            self.hosting.overrideUserInterfaceStyle = preferredColorScheme
            super.init(nibName: nil, bundle: .main)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func present() {
            hosting.presentationController?.delegate = coordinator as UISheetPresentationControllerDelegate
            if let isBeingPresented = presentedViewController?.isBeingPresented {
                return
            } else {
                present(hosting, animated: true, completion: nil)
            }
        }
        
        func dismiss() {
            if let isBeingPresented = presentedViewController?.isBeingPresented, !isBeingPresented {
                // ここのチェックをかけるとデバイスが傾いたときには消えないが、ボタンを押しても消えなくなる
                if let _ = presentedViewController?.isBeingDismissed { return }
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
