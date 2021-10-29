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
                Section(header: Text("List"), content: {
                    NavigationLink(destination: FontView(), label: {
                        Text("Font Lists")
                    })
                })
                Section(header: Text("Camera"), content: {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Text("Camera")
                    })
                })
            })
                .sheet(isPresented: $isPresented, onDismiss: {}, content: {
                    CameraView(cameraMode: .scan)
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
