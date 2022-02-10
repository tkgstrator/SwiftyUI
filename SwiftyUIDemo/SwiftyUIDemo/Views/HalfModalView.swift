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
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("HalfModal")
        })
            .halfsheet(isPresented: $isPresented, onDismiss: {}, content: {
                Text("HalfModalView")
            })
    }
}

struct HalfModalView_Previews: PreviewProvider {
    static var previews: some View {
        HalfModalView()
    }
}
