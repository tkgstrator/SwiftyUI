//
//  VisibleButton.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI
import SwiftyUI

struct VisibleButton: View {
    var body: some View {
        Button(action: {
        }, label: {
            Text("Hosting Dismiss")
        })
    }
}

struct VisibleButton_Previews: PreviewProvider {
    static var previews: some View {
        VisibleButton()
    }
}
