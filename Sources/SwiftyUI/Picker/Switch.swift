//
//  Switch.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

public struct Switch: View {
    @Binding var selected: Bool
    var segmentedLabels: Array<String>
    var selectedItemColor: Color = .twitter
    
    public init(_ selected: Binding<Bool>, _ segmentedLabels: Array<String>) {
        self._selected = selected
        self.segmentedLabels = Array(segmentedLabels.prefix(2))
    }
    
    public init(_ selected: Binding<Bool>, _ segmentedLabels: Array<String>,
                selectedItemColor: Color) {
        self.init(selected, segmentedLabels)
        self.selectedItemColor = selectedItemColor
    }
    
    public var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 2), alignment: .center, spacing: 0, pinnedViews: []) {
            ForEach(segmentedLabels, id:\.self) { label in
                Text(label)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        background(segmentedLabels.firstIndex(of:label), selected)
                            .frame(width: 89, height: 38)
                    )
                    .lineLimit(1)
                    .foregroundColor(selected == (segmentedLabels.firstIndex(of: label) == 0) ? .white : .envy)
                    .onTapGesture {
                        withAnimation {
                            selected = segmentedLabels.firstIndex(of: label) == 0
                        }
                    }
                    .padding()
            }
        }
        .padding()
    }
    
    private func background(_ segmentIndex: Int?, _ selected: Bool) -> some View {
        switch segmentIndex {
        case 0:
            return CapsureRectangle(style: .left)
                .fill(selected ? selectedItemColor : .white)
        case 1:
            return CapsureRectangle(style: .right)
                .fill(!selected ? selectedItemColor : .white)
        default:
            return CapsureRectangle(style: .right)
                .fill(selected ? selectedItemColor : .white)
        }
    }
}
    
#if DEBUG
struct SegmentedControl_Previews: PreviewProvider {
    @State static var selection: Bool = true
    @State static var segmentedLabels: [String] = ["Nyamo", "Nice"]
    
    static var previews: some View {
        Switch($selection, segmentedLabels)
    }
}
#endif
