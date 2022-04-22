//
//  onFirstAppear.swift
//  
//
//  Created by devonly on 2022/03/17.
//

import Foundation
import SwiftUI

public struct ViewFirstLoadModifier: ViewModifier {
    private let action: (() -> Void)?
    
    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
    }
}

extension View {
    public func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewFirstLoadModifier(perform: action))
    }
}
