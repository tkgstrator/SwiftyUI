//
//  ContentView.swift
//  SwiftyUIDemo
//
//  Created by tkgstrator on 2021/07/06.
//

import SwiftUI
import SwiftyUI

struct ContentView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView(content: {
            Form(content: {
                Section(content: {
                    NavigationLink(destination: HalfModalView(), label: {
                        Text("HalfModal Demo")
                    })
                    NavigationLink(destination: ModalView(), label: {
                        Text("Modal Demo")
                    })
                }, header: {
                    Text("SwiftyUI")
                })
                Section(content: {
                    NavigationLink(destination: SheetView(), label: {
                        Text("Sheet")
                    })
                    NavigationLink(destination: FullScreenView(), label: {
                        Text("FullScreen")
                    })
                }, header: {
                    Text("iOS")
                })
                Section(content: {
                    NavigationLink(destination: NavigationLinkView(), label: {
                        Text("PopToRootView")
                    })
                }, header: {
                    Text("NavigationLink")
                })
            })
                .navigationTitle("SwiftyUI Demo")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
