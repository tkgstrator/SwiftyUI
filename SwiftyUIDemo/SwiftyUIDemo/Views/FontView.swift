//
//  FontView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2021/10/29.
//

import SwiftUI
import SwiftyUI

struct FontView: View {
    var body: some View {
        Form(content: {
            ForEach(FontStyle.allCases) { font in
                Text(font.rawValue)
                    .font(systemName: font, size: 16)
            }
        })
            .navigationTitle("FontStyle")
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView()
    }
}
