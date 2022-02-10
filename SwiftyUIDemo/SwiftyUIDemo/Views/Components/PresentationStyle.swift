//
//  PresentationStyle.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI
import SwiftyUI

struct PresentationStyle: View {
    @Binding var presentationStyle: ModalPresentationStyle
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            HStack(content: {
                Text("PresentationStyle")
                Spacer()
                Text(presentationStyle.presentationName)
                    .foregroundColor(.secondary)
            })
        })
            .halfsheet(isPresented: $isPresented, content: {
                Picker(selection: $presentationStyle, content: {
                    ForEach(ModalPresentationStyle.allCases) { style in
                        Text(style.presentationName)
                            .tag(style)
                    }
                }, label: {
                })
                    .pickerStyle(.wheel)
            })
    }
}

extension ModalPresentationStyle {
    var presentationName: String {
        switch self {
        case .automatic:
            return "Automatic"
        case .fullScreen:
            return "Full Screen"
        case .pageSheet:
            return "Page Sheet"
        case .formSheet:
            return "Form Sheet"
        }
    }
}

extension ModalPresentationStyle: Identifiable {
    public var id: Int { rawValue }
}

struct PresentationStyle_Previews: PreviewProvider {
    static var previews: some View {
        PresentationStyle(presentationStyle: .constant(.automatic))
    }
}
