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
            .foregroundColor(configuration.isPressed ? .white : .twitter)
            .overlay(Circle().stroke(Color.twitter, lineWidth: 1))
            .background(Circle().foregroundColor(configuration.isPressed ? .twitter : .clear))
    }
}
