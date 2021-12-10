//
//  NavigationLinker.swift
//  
//
//  Created by devonly on 2021/12/10.
//

import SwiftUI

public struct NavigationLinker<Destination: View, Label: View>: View {
    let destination: Destination
    let label: () -> Label
    
    public init(destination: Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        ZStack(content: {
            NavigationLink(destination: destination, label: {
                EmptyView()
            })
                .opacity(0.0)
            label()
        })
    }
}
