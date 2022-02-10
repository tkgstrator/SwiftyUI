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
        Button(action: {
            dismiss()
        }, label: {
            Text("Dismiss")
        })
    }
}

struct PresentView_Previews: PreviewProvider {
    static var previews: some View {
        PresentView()
    }
}
