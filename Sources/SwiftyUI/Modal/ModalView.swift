//
//  ModalView.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/13.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

struct ModalSheet<Content>: UIViewControllerRepresentable where Content: View {
    
    let content: Content
    @Binding var isPresented: Bool
    let transitionStyle: UIModalTransitionStyle
    let presentationStyle: UIModalPresentationStyle
    let isModalInPresentation: Bool
    let contentSize: CGSize?
    
    init(isPresented: Binding<Bool>,
         transitionStyle: UIModalTransitionStyle = .flipHorizontal,
         presentationStyle: UIModalPresentationStyle = .pageSheet,
         isModalInPresentation: Bool = false,
         contentSize: CGSize?,
         content: Content
    ) {
        self.content = content
        self.transitionStyle = transitionStyle
        self.presentationStyle = presentationStyle
        self.isModalInPresentation = isModalInPresentation
        self.contentSize = contentSize
        self._isPresented = isPresented
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
            contentSize: contentSize,
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
    // context.coordinator.parent.isPresentedとisPresentedは常に同じ値が入っている
    // isPresentedの値を書き換えても何故かすぐに戻ってしまう
    func updateUIViewController(
        _ uiViewController: ViewController<Content>,
        context: Context
    ) {
        // 設定を反映
        uiViewController.transitionStyle = transitionStyle
        uiViewController.presentationStyle = presentationStyle
        uiViewController.isModalInPresentation = isModalInPresentation
        
        context.coordinator.parent = self
        uiViewController.parent?.presentationController?.delegate = context.coordinator
        
        switch isPresented {
        case true:
            uiViewController.present(contentSize: contentSize)
        case false:
            uiViewController.dismiss()
        }
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var parent: ModalSheet
        
        init(_ parent: ModalSheet) {
            self.parent = parent
        }
        
        // 画面外タップでViewをとじたときに呼ばれる
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            if parent.isPresented {
                parent.isPresented = false
            }
        }
    }
    
    final class HostingController<Content: View>: UIHostingController<Content> {
        init(content: Content) {
            super.init(rootView: content)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    // This custom view controller
    final class ViewController<Content: View>: UIViewController {
//        let content: Content
        let coordinator: ModalSheet<Content>.Coordinator
        var transitionStyle: UIModalTransitionStyle
        var presentationStyle: UIModalPresentationStyle
        let hosting: UIHostingController<Content>
        
        init(coordinator: ModalSheet<Content>.Coordinator,
             transitionStyle: UIModalTransitionStyle,
             presentationStyle: UIModalPresentationStyle,
             isModalInPresentation: Bool,
             contentSize: CGSize?,
             content: Content
        ) {
//            self.content = content
            self.coordinator = coordinator
            self.transitionStyle = transitionStyle
            self.presentationStyle = presentationStyle
            self.hosting = UIHostingController(rootView: content)
            super.init(nibName: nil, bundle: .main)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            if coordinator.parent.isPresented {
                coordinator.parent.isPresented.toggle()
            }
            super.dismiss(animated: flag, completion: completion)
        }
        
        // 表示
        func present(contentSize: CGSize?) {
//            let hosting = UIHostingController(rootView: content)
            // UIHostingControllerでボタンが効かなくなるバグの修正
            hosting.view.translatesAutoresizingMaskIntoConstraints = false
            hosting.updateViewConstraints()
            // ここまで
            hosting.modalTransitionStyle = transitionStyle
            if let contentSize = contentSize {
                hosting.preferredContentSize = contentSize
                hosting.modalPresentationStyle = .formSheet
            } else {
                hosting.modalPresentationStyle = presentationStyle
            }
            hosting.presentationController?.delegate = coordinator as UIAdaptivePresentationControllerDelegate
            hosting.isModalInPresentation = isModalInPresentation
            
            if let isBeingPresented = presentedViewController?.isBeingPresented {
                if let contentSize = contentSize, !isBeingPresented {
                    presentedViewController?.preferredContentSize = contentSize
                }
            } else {
                present(hosting, animated: true, completion: nil)
            }
        }
        
        // 表示されているViewがあるときだけとじる
        func dismiss() {
            dismiss(animated: true, completion: nil)
        }
    }
}
