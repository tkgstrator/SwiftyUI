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
    func sheet<Content: View>(
        isPresented: Binding<Bool>,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentationStyle: UIModalPresentationStyle = .pageSheet,
        isModalInPresentation: Bool = false,
        contentSize: CGSize? = nil,
        content: @escaping () -> Content
    ) -> some View {
        self.overlay(
            ModalSheet(
                isPresented: isPresented,
                transitionStyle: transitionStyle,
                presentationStyle: presentationStyle,
                isModalInPresentation: isModalInPresentation,
                contentSize: contentSize,
                content: content().environment(\.dismissModal, DismissModalAction(isPresented))
            )
                .frame(width: 0, height: 0)
        )
    }
}
