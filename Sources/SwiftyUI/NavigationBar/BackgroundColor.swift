//
//  BackgroundColor.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

struct BackgroundColorModifier: ViewModifier {

    init(color: Color) {
        UITableView.appearance().backgroundColor = UIColor(color)
    }
    
    func body(content: Content) -> some View {
        content
    }
}

public extension View {
    func backgroundColor(_ color: Color) -> some View {
        self.modifier(BackgroundColorModifier(color: color))
    }
}
