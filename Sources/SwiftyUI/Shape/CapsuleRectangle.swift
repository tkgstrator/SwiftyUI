//
//  CapsureRectangle.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//
//  Magi Corporation, All rights, reserved.

import SwiftUI

public struct CapsureRectangle: Shape {
    private var style: CapsureRectangleStyle
    
    public init(style: CapsureRectangleStyle) {
        self.style = style
    }
    
    public func path(in rect: CGRect) -> Path {
        switch style {
        case .right:
            return rightPath(in: rect)
        case .left:
            return leftPath(in: rect)
        case .center:
            return centerPath(in: rect)
        }
    }
    
    private func centerPath(in rect: CGRect) -> Path {
        Path { path in
            path.addRect(CGRect(x: 0, y: 0, width: rect.maxX, height: rect.maxY))
        }
    }
    
    private func rightPath(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX - rect.maxY, y: 0))
            path.addArc(center: CGPoint(x: rect.maxX - rect.maxY * 0.5, y: rect.maxY * 0.5), radius: rect.maxY * 0.5, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
        }
    }

    private func leftPath(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxY, y: 0))
            path.addArc(center: CGPoint(x: rect.maxY * 0.5, y: rect.maxY * 0.5), radius: rect.maxY * 0.5, startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            path.closeSubpath()
        }
    }
}

public enum CapsureRectangleStyle: CaseIterable {
    case right
    case left
    case center
}
