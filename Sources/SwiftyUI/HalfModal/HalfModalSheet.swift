//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2022/01/29.
//

import SwiftUI

struct HalfModalSheet<Content>: UIViewControllerRepresentable where Content: View {
    
    let content: () -> Content
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme
    let onDismiss: () -> Void
    let detents: [UISheetPresentationController.Detent]
    let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let isModalInPresentation: Bool
    let modalPresentationStyle: ModalPresentationStyle
    let modalTransitionStyle: ModalTransitionStyle
    
    init(
        isPresented: Binding<Bool>,
        detents: [UISheetPresentationController.Detent],
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        prefersEdgeAttachedInCompactHeight: Bool,
        widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
        isModalInPresentation: Bool,
        modalPresentationStyle: ModalPresentationStyle,
        modalTransitionStyle: ModalTransitionStyle,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content
        self.detents = detents
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.modalPresentationStyle = modalPresentationStyle
        self.modalTransitionStyle = modalTransitionStyle
        self.isModalInPresentation = isModalInPresentation
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> CustomHostingController<Content> {
        return CustomHostingController(
            coordinator: context.coordinator,
            preferredColorScheme: colorScheme == .dark ? .dark : .light,
            content: content
        )
    }
    
    func updateUIViewController(
        _ uiViewController: CustomHostingController<Content>,
        context: Context
    ) {
        context.coordinator.parent = self

        // Delegate
        uiViewController.parent?.presentationController?.delegate = context.coordinator
        
        switch isPresented {
            case true:
                uiViewController.present()
            case false:
                uiViewController.dismiss()
        }
    }
    
    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfModalSheet
        
        init(_ parent: HalfModalSheet) {
            self.parent = parent
        }
        
        // 画面外タップでViewをとじたときに呼ばれる
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            print("DISMISS")
            if parent.isPresented {
                parent.isPresented = false
            }
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
            self.content = content()
            self.coordinator = coordinator
            self.hosting = UIHostingController(rootView: content())
            super.init(nibName: nil, bundle: .main)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            print("DISAPPEAR")
        }
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            print("OVERRIDE DISMISS")
            if coordinator.parent.isPresented {
                coordinator.parent.isPresented.toggle()
            }
            super.dismiss(animated: flag, completion: completion)
        }
        
        // 表示
        func present() {
            // 設定を反映
            hosting.presentationController?.delegate = coordinator as UIAdaptivePresentationControllerDelegate
            hosting.sheetPresentationController?.detents = coordinator.parent.detents
            hosting.sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = coordinator.parent.widthFollowsPreferredContentSizeWhenEdgeAttached
            hosting.sheetPresentationController?.prefersEdgeAttachedInCompactHeight = coordinator.parent.prefersEdgeAttachedInCompactHeight
            hosting.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = coordinator.parent.prefersScrollingExpandsWhenScrolledToEdge
            hosting.modalTransitionStyle = UIModalTransitionStyle(rawValue: coordinator.parent.modalTransitionStyle.rawValue)!
            hosting.modalPresentationStyle = UIModalPresentationStyle(rawValue: coordinator.parent.modalPresentationStyle.rawValue)!
            hosting.isModalInPresentation = coordinator.parent.isModalInPresentation
            
            if let isBeingPresented = presentedViewController?.isBeingPresented {
            } else {
                // 新規表示
                present(hosting, animated: true, completion: nil)
            }
        }
        
        func dismiss() {
            print("FUNC DISMISS")
            if let isBeingPresented = presentedViewController?.isBeingPresented, !isBeingPresented {
                // ここのチェックをかけるとデバイスが傾いたときには消えないが、ボタンを押しても消えなくなる
                if let _ = presentedViewController?.isBeingDismissed { return }
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
