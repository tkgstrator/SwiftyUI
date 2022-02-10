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
                    Text("Modal")
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
