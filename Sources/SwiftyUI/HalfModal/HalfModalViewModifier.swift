//
//  File.swift
//  
//
//  Created by devonly on 2022/02/11.
//

import Foundation
import SwiftUI

public extension View {
    func halfsheet<Content: View>(
        isPresented: Binding<Bool>,
        detents: DetentsIdentifier = .medium,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = false,
        prefersEdgeAttachedInCompactHeight: Bool = false,
        widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false,
        isModalInPresentation: Bool = false,
        modalPresentationStyle: ModalPresentationStyle = .automatic,
        modalTransitionStyle: ModalTransitionStyle = .coverVertical,
        onDismiss: @escaping () -> (),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .background(
                HalfModalSheet(
                    isPresented: isPresented,
                    detents: detents.rawValue,
                    largestUndimmedDetentIdentifier: largestUndimmedDetentIdentifier,
                    prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                    prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                    widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                    isModalInPresentation: isModalInPresentation,
                    modalPresentationStyle: modalPresentationStyle,
                    modalTransitionStyle: modalTransitionStyle,
                    onDismiss: onDismiss,
                    content: content
                )
            )
    }
}

public enum DetentsIdentifier {
    case medium
    case large
    case both
    
    var rawValue: [UISheetPresentationController.Detent] {
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
