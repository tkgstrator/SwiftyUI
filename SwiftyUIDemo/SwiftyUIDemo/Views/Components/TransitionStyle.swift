//
//  TransitionStyle.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI
import SwiftyUI

struct TransitionStyle: View {
    @Binding var transitionStyle: UIModalTransitionStyle
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            HStack(content: {
                Text("TransitionStyle")
                Spacer()
                Text(transitionStyle.transitionName)
                    .foregroundColor(.secondary)
            })
        })
            .halfsheet(isPresented: $isPresented, content: {
                Picker(selection: $transitionStyle, content: {
                    ForEach(UIModalTransitionStyle.allCases) { style in
                        Text(style.transitionName)
                            .tag(style)
                    }
                }, label: {
                })
                    .pickerStyle(.wheel)
            })
    }
}

extension UIModalTransitionStyle {
    var transitionName: String {
        switch self {
        case .coverVertical:
            return "Cover Vertical"
        case .flipHorizontal:
            return "Flip Horizontal"
        case .crossDissolve:
            return "Cross Dissolve"
        case .partialCurl:
            return "PartialCurl"
        @unknown default:
            return "Default"
        }
    }
}

extension UIModalTransitionStyle: Identifiable {
    public var id: Int { rawValue }
}

extension UIModalTransitionStyle: CaseIterable {
    public static var allCases: [UIModalTransitionStyle] {
        [.coverVertical, .crossDissolve, .flipHorizontal, .partialCurl]
    }
}


struct TransitionStyle_Previews: PreviewProvider {
    static var previews: some View {
        TransitionStyle(transitionStyle: .constant(.flipHorizontal))
    }
}
