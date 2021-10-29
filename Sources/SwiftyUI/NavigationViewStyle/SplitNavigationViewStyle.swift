//
//  SplitNavigationViewStyle.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

public struct SplitNavigationViewStyle: NavigationViewStyle {
    public func _columnBasedBody(configuration: _NavigationViewStyleConfiguration) -> EmptyView {
        EmptyView()
    }
    
    struct ControllerModifier: ViewModifier {
        struct ControllerView: UIViewControllerRepresentable {
            class ViewController: UIViewController {
                
                override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    guard let svc = self.parent?.children.first as? UISplitViewController else { return }
                    svc.preferredDisplayMode = .oneBesideSecondary
                    svc.preferredSplitBehavior = .tile
                    svc.presentsWithGesture = false
                }
            }
            
            func makeUIViewController(context: Self.Context) -> UIViewController {
                return ViewController()
            }
            
            func updateUIViewController(_ uiViewController: UIViewController, context: Self.Context) {
            }
        }
        
        func body(content: Content) -> some View {
            content.overlay(
                ControllerView().frame(width: 0, height: 0)
            )
        }
    }
    
    public func _body(configuration: _NavigationViewStyleConfiguration) -> some View {
        NavigationView {
            configuration.content
        }
        .modifier(ControllerModifier())
    }
    
    public init() {
    }
}