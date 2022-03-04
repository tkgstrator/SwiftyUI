//
//  FullScreenView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI

struct FullScreenView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Form(content: {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Modal")
            })
                .fullScreenCover(isPresented: $isPresented, onDismiss: {}, content: {
                    PresentView()
                })
        })
            .navigationTitle("FullScreen View")
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenView()
    }
}
