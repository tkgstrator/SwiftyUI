//
//  NavigationButton.swift
//  
//
//  Created by devonly on 2021/12/10.
//

import SwiftUI

public struct NavigationButton<Destination: View, Label: View>: View {
    let destination: Destination
    let label: () -> Label
    @State var isPresented: Bool = false
    
    public init(destination: Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            label()
                .background(NavigationLink(destination: destination, isActive: $isPresented, label: { EmptyView() }))
        })
    }
}
