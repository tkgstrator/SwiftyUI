//
//  HalfModalView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI
import SwiftyUI

struct HalfModalView: View {
    @State var isPresented: Bool = false
    @State var detentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium
    @State var prefersScrollingExpandsWhenScrolledToEdge: Bool = false
    @State var prefersEdgeAttachedInCompactHeight: Bool = false
    @State var widthFollowsPreferredContentSizeWhenEdgeAttached: Bool = false
    @State var isModalInPresentation: Bool = false
    @State var transitionStyle: ModalTransitionStyle = .coverVertical
    @State var presentationStyle: ModalPresentationStyle = .automatic
    @State var detents: DetentsIdentifier = .medium
    
    var body: some View {
        Form(content: {
            Detents(detents: $detents)
            DetentIdentifier(detentIdentifier: $detentIdentifier)
            PresentationStyle(presentationStyle: $presentationStyle)
            TransitionStyle(transitionStyle: $transitionStyle)
            Toggle(isOn: $prefersScrollingExpandsWhenScrolledToEdge, label: {
                Text("PrefersScrollingExpandsWhenScrolledToEdge")
            })
            Toggle(isOn: $prefersEdgeAttachedInCompactHeight, label: {
                Text("PrefersEdgeAttachedInCompactHeight")
            })
            Toggle(isOn: $widthFollowsPreferredContentSizeWhenEdgeAttached, label: {
                Text("WidthFollowsPreferredContentSizeWhenEdgeAttached")
            })
            Toggle(isOn: $isModalInPresentation, label: {
                Text("IsModalInPresentation")
            })
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("HalfModal")
            })
                .halfsheet(
                    isPresented: $isPresented,
                    transitionStyle: transitionStyle,
                    presentationStyle: presentationStyle,
                    isModalInPresentation: isModalInPresentation,
                    detentIdentifier: detentIdentifier,
                    prefersScrollingExpandsWhenScrolledToEdge: prefersScrollingExpandsWhenScrolledToEdge,
                    prefersEdgeAttachedInCompactHeight: prefersEdgeAttachedInCompactHeight,
                    detents: detents,
                    widthFollowsPreferredContentSizeWhenEdgeAttached: widthFollowsPreferredContentSizeWhenEdgeAttached,
                    content: {
                        PresentView()
                    })
        })
    }
}

struct HalfModalView_Previews: PreviewProvider {
    static var previews: some View {
        HalfModalView()
    }
}
