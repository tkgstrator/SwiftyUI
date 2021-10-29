//
//  ModalViewModifier.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/13.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

public extension View {
    /// モーダルをUIKit風に表示する
    func present<Content: View>(
        isPresented: Binding<Bool>,
        transitionStyle: ModalTransitionStyle = .coverVertical,
        presentationStyle: ModalPresentationStyle = .pageSheet,
        isModalInPresentation: Bool = false,
        contentSize: CGSize? = nil,
        content: @escaping () -> Content
    ) -> some View {
        self.overlay(
            ModalPresent(isPresented: isPresented,
                  transitionStyle: transitionStyle,
                  presentationStyle: presentationStyle,
                  isModalInPresentation: isModalInPresentation,
                  contentSize: contentSize,
                  content: content)
                .frame(width: 0, height: 0)
                .buttonStyle(PlainButtonStyle())
        )
    }
}

public enum ModalTransitionStyle: Int, CaseIterable {
    case coverVertical  = 0
    case flipHorizontal = 1
    case crossDissolve  = 2
}

public enum ModalPresentationStyle: Int, CaseIterable {
    case automatic  = -2
    case fullScreen = 0
    case pageSheet  = 1
    case formSheet  = 2
}
