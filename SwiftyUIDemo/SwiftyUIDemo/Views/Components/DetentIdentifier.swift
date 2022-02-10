//
//  DetentIdentifier.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/11.
//

import SwiftUI
import SwiftyUI

struct DetentIdentifier: View {
    @Binding var detentIdentifier: UISheetPresentationController.Detent.Identifier
    @State var isPresented: Bool = false
    let detents: [UISheetPresentationController.Detent.Identifier?]  = [.medium, .large, .none]
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            HStack(content: {
                Text("DetentIdentifier")
                Spacer()
                Text(detentIdentifier.detentName)
                    .foregroundColor(.secondary)
            })
        })
            .halfsheet(isPresented: $isPresented, content: {
                Picker(selection: $detentIdentifier, content: {
                    ForEach(detents) { style in
                        Text(style.detentName)
                            .tag(style)
                    }
                }, label: {
                })
                    .pickerStyle(.wheel)
            })
    }
}

extension Optional: Identifiable where Wrapped == UISheetPresentationController.Detent.Identifier {
    public var id: String? { self?.rawValue }
}

extension UISheetPresentationController.Detent.Identifier {
    var detentName: String {
        switch self {
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        default:
            return "Default"
        }
    }
}

extension Optional where Wrapped == UISheetPresentationController.Detent.Identifier {
    var detentName: String {
        switch self {
        case .some(let value):
            switch value {
            case .medium:
                return "Medium"
            case .large:
                return "Large"
            default:
                return "Default"
            }
        case .none:
            return "Disable"
        }
    }
}

struct DetentIdentifier_Previews: PreviewProvider {
    static var previews: some View {
        DetentIdentifier(detentIdentifier: .constant(.medium))
    }
}
