//
//  SheetView.swift
//  SwiftyUIDemo
//
//  Created by devonly on 2022/02/10.
//

import SwiftUI

struct SheetView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Form(content: {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Modal")
            })
                .sheet(isPresented: $isPresented, content: {
                    PresentView()
                })
        })
            .navigationTitle("Sheet View")
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
