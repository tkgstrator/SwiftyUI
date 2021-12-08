//
//  SegmentControl.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI
import UIKit

public struct SegmentControl: View {
    @Binding var selection: Int
    var items: [String]
    var fillColor: Color = .twitter
    
    public init(selection: Binding<Int>, items: [String]) {
        self._selection = selection
        self.items = items
    }

    public init(selection: Binding<Int>, items: [String], fillColor: Color) {
        self._selection = selection
        self.items = items
        self.fillColor = fillColor
    }

    public var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: 54, maximum: 54), spacing: nil), count: items.count), alignment: .center, spacing: nil, pinnedViews: []) {
            ForEach(items, id:\.self) { item in
                Text(item)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Capsule()
                            .fill(items[selection] == item ? fillColor : .clear)
                    )
                    .lineLimit(1)
                    .foregroundColor(items[selection] == item ? .white : fillColor)
                    .onTapGesture {
                        withAnimation {
                            selection = items.firstIndex(of: item)!
                        }
                    }
            }
        }
        .padding()
    }
}
