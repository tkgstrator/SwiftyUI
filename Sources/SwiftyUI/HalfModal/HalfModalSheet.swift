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
    let transitionStyle: UIModalTransitionStyle
    let presentationStyle: UIModalPresentationStyle
    let isModalInPresentation: Bool
    let detentIdentifier: UISheetPresentationController.Detent.Identifier?
    let prefersScrollingExpandsWhenScrolledToEdge: Bool
    let prefersEdgeAttachedInCompactHeight: Bool
    let widthFollowsPreferredContentSizeWhenEdgeAttached: Bool
    let detents: DetentsIdentifier
    let prefersGrabberVisible: Bool
    let onDismiss: () -> Void

    internal init(
        isPresented: Binding<Bool>,
        transitionStyle: UIModalTransitionStyle,
        presentationStyle: UIModalPresentationStyle,
        isModalInPresentation: Bool,
        detentIdentifier: UISheetPresentationController.Detent.Identifier?,
        prefersScrollingExpandsWhenScrolledToEdge: Bool,
        prefersEdgeAttachedInCompactHeight: Bool,
        detents: DetentsIdentifier,
        widthFollowsPreferredContentSizeWhenEdgeAttached: Bool,
        prefersGrabberVisible: Bool,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
        self.isModalInPresentation = isModalInPresentation
        self.detentIdentifier = detentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.prefersEdgeAttachedInCompactHeight = prefersEdgeAttachedInCompactHeight
        self.widthFollowsPreferredContentSizeWhenEdgeAttached = widthFollowsPreferredContentSizeWhenEdgeAttached
        self.detents = detents
        self.prefersGrabberVisible = prefersGrabberVisible
        self.onDismiss = onDismiss
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ViewController<Content> {
        return ViewController(
            coordinator: context.coordinator,
            transitionStyle: transitionStyle,
            presentationStyle: presentationStyle,
            isModalInPresentation: isModalInPresentation,
            preferredColorScheme: colorScheme == .dark ? .dark : .light,
            content: content
        )
    }
    
    // isPresentedの値が変化したときに呼ばれる
    // デバイスの向きが変わった場合も呼ばれる
    // - 補足説明
    // isPresentedの値を変えると何故か20回呼ばれる
    // 最初の1回目だけ正しくisPresentedにTrueが入っているが、
    // 2回目以降はFalseが入っていてこれが様々なバグの原因
    // isPresented=FalseになっているのでModalはViewが再レンダリングされたら消える状態
    // デバイスを傾けるとやはりこのメソッドが呼ばれ、isPresented=Falseなのでdismiss()が実行される
    // もしdismiss()で何も条件分岐をしない場合は2回目以降のdismiss()によって開いたViewがとじられてしまう
    // - 解決案
    // 1. updateUIViewControllerが1回しか呼ばれないようにする
    // 2. Viewが開いた状態なのに何故かisPresented=Falseになる原因を特定し、ならないようにする
    // 3. dismiss()の判定をより厳密化する
    // - 備考
    // context.coordinator.parent.isPresentedとisPresentedは常に同じ値が入っているよう
    // isPresentedの値を書き換えても何故かすぐに戻ってしまう
    func updateUIViewController(
        _ uiViewController: ViewController<Content>,
        context: Context
    ) {
        context.coordinator.parent = self
        uiViewController.parent?.presentationController?.delegate = context.coordinator
        
        switch isPresented {
        case true:
            uiViewController.present()
        case false:
            uiViewController.dismiss()
        }
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfModalSheet
        
        init(_ parent: HalfModalSheet) {
            self.parent = parent
        }
        
        // 画面外タップ/下にスワイプでViewをとじたときに実行される
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            if parent.isPresented {
                parent.isPresented = false
            }
            parent.onDismiss()
        }
    }
    
    // This custom view controller
    final class ViewController<Content: View>: UIViewController {
        let content: Content
        let coordinator: HalfModalSheet<Content>.Coordinator
        var transitionStyle: UIModalTransitionStyle
        var presentationStyle: UIModalPresentationStyle
        let preferredColorScheme: UIUserInterfaceStyle
        let hosting: UIHostingController<Content>
        
        init(coordinator: HalfModalSheet<Content>.Coordinator,
             transitionStyle: UIModalTransitionStyle,
             presentationStyle: UIModalPresentationStyle,
             isModalInPresentation: Bool,
             preferredColorScheme: UIUserInterfaceStyle,
             @ViewBuilder content: @escaping () -> Content
        ) {
            self.content = content()
            self.coordinator = coordinator
            self.transitionStyle = transitionStyle
            self.presentationStyle = presentationStyle
            self.preferredColorScheme = preferredColorScheme
            self.hosting = UIHostingController(rootView: content())
            super.init(nibName: nil, bundle: .main)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // Environment(\.dismiss)を呼んだときに実行される
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            // isPresentedが切り替わってなかったらFalseにする
            if coordinator.parent.isPresented {
                coordinator.parent.isPresented.toggle()
            }
            super.dismiss(animated: flag, completion: completion)
        }
        
        // 表示
        func present() {
            // 設定を反映
//            let hosting: UIHostingController = UIHostingController(rootView: content)
            // UIHostingControllerでボタンが効かなくなるバグの修正
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            hosting.updateViewConstraints()
            // ここまで
            hosting.modalTransitionStyle = UIModalTransitionStyle(rawValue: transitionStyle.rawValue)!
            hosting.modalPresentationStyle = UIModalPresentationStyle(rawValue: presentationStyle.rawValue)!
            hosting.sheetPresentationController?.delegate = coordinator as UISheetPresentationControllerDelegate
            hosting.isModalInPresentation = isModalInPresentation
            hosting.overrideUserInterfaceStyle = preferredColorScheme
            // UISheetPresentationController
            hosting.sheetPresentationController?.detents = coordinator.parent.detents.value
            hosting.sheetPresentationController?.largestUndimmedDetentIdentifier = coordinator.parent.detentIdentifier
            hosting.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = coordinator.parent.prefersScrollingExpandsWhenScrolledToEdge
            hosting.sheetPresentationController?.prefersEdgeAttachedInCompactHeight = coordinator.parent.prefersEdgeAttachedInCompactHeight
            hosting.sheetPresentationController?.widthFollowsPreferredContentSizeWhenEdgeAttached = coordinator.parent.widthFollowsPreferredContentSizeWhenEdgeAttached
            hosting.sheetPresentationController?.prefersGrabberVisible = coordinator.parent.prefersGrabberVisible
            
            if let isBeingPresented = presentedViewController?.isBeingPresented {
            } else {
                // 新規表示
                present(hosting, animated: true, completion: nil)
            }
        }
        
        // 表示されているViewがあるときだけとじる
        func dismiss() {
            if let isBeingPresented = presentedViewController?.isBeingPresented, !isBeingPresented {
                // ここのチェックをかけるとデバイスが傾いたときには消えないが、ボタンを押しても消えなくなる
                if let _ = presentedViewController?.isBeingDismissed { return }
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
