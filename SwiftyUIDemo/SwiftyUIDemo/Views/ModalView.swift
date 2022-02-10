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
    @State var transitionStyle: ModalTransitionStyle = .crossDissolve
    @State var presentationStyle: ModalPresentationStyle = .automatic
    @State var isModalInPresentation: Bool = false
    
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
            .present(
                isPresented: $isPresented,
                transitionStyle: transitionStyle,
                presentationStyle: presentationStyle,
                isModalInPresentation: isModalInPresentation,
                contentSize: nil, content: {
                    PresentView()
                })
        })
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
