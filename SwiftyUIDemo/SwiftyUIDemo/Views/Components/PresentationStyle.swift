//
//  PresentationStyle.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI
import SwiftyUI

struct PresentationStyle: View {
    @Binding var presentationStyle: UIModalPresentationStyle
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
                    ForEach(UIModalPresentationStyle.allCases) { style in
                        Text(style.presentationName)
                            .tag(style)
                    }
                }, label: {
                })
                    .pickerStyle(.wheel)
            })
    }
}

extension UIModalPresentationStyle {
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
        case .currentContext:
            return "CurrentContext"
        case .custom:
            return "Custom"
        case .overFullScreen:
            return "OverFullScreen"
        case .overCurrentContext:
            return "OverCurrentContext"
        case .popover:
            return "Popover"
        case .none:
            return "None"
        @unknown default:
            return "Default"
        }
    }
}

extension UIModalPresentationStyle: Identifiable {
    public var id: Int { rawValue }
}

extension UIModalPresentationStyle: CaseIterable {
    public static var allCases: [UIModalPresentationStyle] {
        [.automatic, .fullScreen, .pageSheet, .formSheet, .currentContext, .custom, .overFullScreen, .overCurrentContext, .popover, .none]
    }
}

struct PresentationStyle_Previews: PreviewProvider {
    static var previews: some View {
        PresentationStyle(presentationStyle: .constant(.automatic))
    }
}
