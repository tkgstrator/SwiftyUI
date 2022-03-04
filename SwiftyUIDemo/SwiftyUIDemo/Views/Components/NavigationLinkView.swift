//
//  NavigationLinkView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/03/04.
//

import SwiftUI

struct NavigationLinkView: View {
    var body: some View {
        Form(content: {
            NavigationLink(destination: NavigationLinkView(), label: {
                Text("NavigationLink")
            })
            DismissButton()
            PopButton()
        })
            .navigationTitle("NavigationLink")
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView()
    }
}
