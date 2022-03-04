//
//  DismissButton.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI
import SwiftyUI

struct DismissButton: View {
    @Environment(\.dismissModal) var dismissModal
    @Environment(\.dismiss) var dismiss
    @Environment(\.popToRoot) var popToRoot
    
    var body: some View {
        Group(content: {
            Button(action: {
                dismiss()
            }, label: {
                Text("Dismiss(iOS)")
            })
            Button(action: {
                dismissModal()
            }, label: {
                Text("Dismiss(SwiftyUI)")
            })
            Button(action: {
                popToRoot()
            }, label: {
                Text("PopToRoot(SwiftyUI)")
            })
        })
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
