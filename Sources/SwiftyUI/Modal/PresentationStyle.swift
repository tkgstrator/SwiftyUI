//
//  PresentationStyle.swift
//  
//  SwiftyUI
//  Created by devonly on 2021/09/08.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

public struct PresentationStyle {
    public var isPresented: Binding<Bool>

    public func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            guard let visibleController = UIApplication.shared.visibleViewController() else { return }
            visibleController.dismiss(animated: true, completion: nil)
            visibleController.isModalInPresentation = false
            isPresented.wrappedValue.toggle()
        })
    }
    
    public init(_ isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
}

struct ModalIsPresented: EnvironmentKey {

    static var defaultValue: Binding<PresentationStyle> = .constant(PresentationStyle(.constant(false)))
    
    typealias Value = Binding<PresentationStyle>
}

extension EnvironmentValues {
    public var modalIsPresented: Binding<PresentationStyle> {
        get {
            return self[ModalIsPresented.self]
        }
        set {
            self[ModalIsPresented.self] = newValue
        }
    }
}

extension UIApplication {
    func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return nil }
        guard let rootViewController = window.rootViewController else { return nil }
        return UIApplication.getVisibleViewControllerFrom(vc: rootViewController)
    }

    private static func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
            let visibleController = navigationController.visibleViewController  {
            return UIApplication.getVisibleViewControllerFrom( vc: visibleController )
        } else if let tabBarController = vc as? UITabBarController,
            let selectedTabController = tabBarController.selectedViewController {
            return UIApplication.getVisibleViewControllerFrom(vc: selectedTabController )
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIApplication.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}
