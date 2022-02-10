//
//  Detents.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/11.
//

import SwiftUI
import SwiftyUI

struct Detents: View {
    @Binding var detents: DetentsIdentifier
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            HStack(content: {
                Text("Detents")
                Spacer()
                Text(detents.identifier)
                    .foregroundColor(.secondary)
            })
        })
            .halfsheet(isPresented: $isPresented, content: {
                Picker(selection: $detents, content: {
                    ForEach(DetentsIdentifier.allCases) { style in
                        Text(style.identifier)
                            .tag(style)
                    }
                }, label: {
                })
                    .pickerStyle(.wheel)
            })
    }
}

extension DetentsIdentifier: Identifiable {
    public var id: Int { rawValue }
}

extension DetentsIdentifier {
    var identifier: String {
        switch self {
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .both:
            return "Both"
        }
    }
}

struct Detents_Previews: PreviewProvider {
    static var previews: some View {
        Detents(detents: .constant(.medium))
    }
}
