//
//  File.swift
//  
//
//  Created by devonly on 2022/02/11.
//

import Foundation
import SwiftUI

public extension View {
    /// モーダルをUIKit風に表示する
    func halfsheet<Content: View>(
        isPresented: Binding<Bool>,
        transitionStyle: ModalTransitionStyle = .coverVertical,
        presentationStyle: ModalPresentationStyle = .automatic,
        isModalInPresentation: Bool = false,
        detentIdentifier: UISheetPresentationController.Detent.Identifier? = .none,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
        prefersEdgeAttachedInCompactHeight: Bool = false,
        detents: DetentsIdentifier = .medium,
        widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false,
        prefersGrabberVisible: Bool = true,
        onDismiss: @escaping () -> Void = {},
        content: @escaping () -> Content
    ) -> some View {
        self.overlay(
            HalfModalSheet(
                isPresented: isPresented,
                transitionStyle: transitionStyle,
                presentationStyle: presentationStyle,
                isModalInPresentation: isModalInPresentation,
                detentIdentifier: detentIdentifier,
                prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                detents: detents,
                widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                prefersGrabberVisible: prefersGrabberVisible,
                onDismiss: onDismiss,
                content: content
            )
                .frame(width: 0, height: 0)
        )
    }
}

public enum DetentsIdentifier: Int, CaseIterable {
    case medium
    case large
    case both
    
    var value: [UISheetPresentationController.Detent] {
        switch self {
        case .medium:
            return [.medium()]
        case .large:
            return [.large()]
        case .both:
            return [.medium(), .large()]
        }
    }
}
