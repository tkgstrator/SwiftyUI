//
//  PopButton.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI
import SwiftyUI

struct PopButton: View {
    var body: some View {
        Button(action: {
        }, label: {
            Text("Dismiss(Pop)")
        })
    }
}

struct PopButton_Previews: PreviewProvider {
    static var previews: some View {
        PopButton()
    }
}
