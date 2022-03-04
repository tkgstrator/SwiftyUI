//
//  Dummy.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI

struct Dummy: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Section(content: {
            Group(content: {
                DismissButton()
            })
            VStack(content: {
                PopButton()
            })
            VStack(content: {
                VisibleButton()
            })
        })
    }
}

struct Dummy_Previews: PreviewProvider {
    static var previews: some View {
        Dummy()
    }
}
