//
//  ModalView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI
import SwiftyUI

struct ModalView: View {
    @State var isPresented: Bool = false
    @State var transitionStyle: UIModalTransitionStyle = .crossDissolve
    @State var presentationStyle: UIModalPresentationStyle = .automatic
    @State var isModalInPresentation: Bool = true
    
    var body: some View {
        Form(content: {
            TransitionStyle(transitionStyle: $transitionStyle)
            PresentationStyle(presentationStyle: $presentationStyle)
            Toggle(isOn: $isModalInPresentation, label: {
                Text("IsModalInPresentation")
            })
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Modal")
            })
            .sheet(
                isPresented: $isPresented,
                transitionStyle: transitionStyle,
                presentationStyle: presentationStyle,
                isModalInPresentation: isModalInPresentation,
                contentSize: nil,
                content: {
                    PresentView()
                })
        })
            .navigationTitle("Modal View")
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
