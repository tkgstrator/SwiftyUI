//
//  PresentView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI

struct PresentView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form(content: {
            Section(content: {
                DismissButton()
                PopButton()
                VisibleButton()
            }, header: {
                Text("Normal")
            })
            Section(content: {
                Dummy()
            }, header: {
                Text("Embedded")
            })
        })
    }
}

struct PresentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentView()
    }
}
