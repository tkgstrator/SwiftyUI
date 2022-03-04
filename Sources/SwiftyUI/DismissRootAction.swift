//
//  DismissRootAction.swift
//  
//
//  Created by devonly on 2022/03/04.
//

import Foundation
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public class DismissRootAction {
    private func dismiss() {
        UIApplication.shared.popToRootView()
    }
    
    public func callAsFunction() { dismiss() }
    
    public init() {}
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct DismissRootKey: EnvironmentKey {
    static var defaultValue: DismissRootAction = DismissRootAction()
    
    typealias Value = DismissRootAction
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public extension EnvironmentValues {
    /// Dismisses the current presentation.
    var popToRoot: DismissRootAction {
        get { self[DismissRootKey.self] }
        set { self[DismissRootKey.self] = newValue }
    }
}
