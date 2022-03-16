//
//  CircleButtonStyle.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//
//  Magi Corporation, All rights, reserved.

import SwiftUI

public struct CircleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .white : .blue)
            .overlay(Circle().stroke(Color.blue, lineWidth: 1))
            .background(Circle().foregroundColor(configuration.isPressed ? .blue : .clear))
    }
}
