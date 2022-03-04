//
//  SwiftyUI.swift
//  
//
//  Created by devonly on 2022/03/04.
//

import Foundation
import UIKit
import SwiftUI

extension UIApplication {
    /// Pop to Root View in NavigationView
    internal func popToRootView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController,
           let navigationController = findNavigationController(viewController: rootViewController)
        {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    /// Dismiss HostingView
    internal func dismiss() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        {
            let visibleViewController = findVisibleViewController(viewController: rootViewController)
            print(visibleViewController)
            visibleViewController.dismiss(animated: true, completion: nil)
        }
    }
   
    private func findVisibleViewController(viewController: UIViewController) -> UIViewController {
        /// UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleController = navigationController.visibleViewController
        {
            return findVisibleViewController(viewController: visibleController)
        }
        
        /// UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedTabController = tabBarController.selectedViewController
        {
            return findVisibleViewController(viewController: selectedTabController)
        }
        
        /// PresentedViewController
        if let presentedViewController = viewController.presentedViewController {
            return findVisibleViewController(viewController: presentedViewController)
        }
        
        return viewController
    }
    
    private func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
