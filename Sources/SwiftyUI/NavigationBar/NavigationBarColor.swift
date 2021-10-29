//
//  NavigationBarColor.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI
import UIKit

public struct NavigationBarColor: ViewModifier {
    init(backgroundColor: Color, tintColor: Color) {
        // Color -> UIColor
        let backgroundColor = UIColor(backgroundColor)
        let tintColor = UIColor(tintColor)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                       
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = tintColor
    }
    
    public func body(content: Content) -> some View {
        content
    }
}

public extension View {
    func navigationBarColor(backgroundColor: Color, tintColor: Color) -> some View {
        self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}
