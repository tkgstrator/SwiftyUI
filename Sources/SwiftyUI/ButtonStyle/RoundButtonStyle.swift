//
//  RoundButtonStyle.swift
//
//  SwiftyUI
//  Created by devonly on 2022/01/23.
//
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

public struct RoundButtonStyle: ButtonStyle {
    let backgroundColor: Color
    public init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .padding(.horizontal, 4)
            .background(backgroundColor)
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.primary, lineWidth: 3))
            .foregroundColor(.white)
            .font(.body.bold())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: UUID())
    }
}
