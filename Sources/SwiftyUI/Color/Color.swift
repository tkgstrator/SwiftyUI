//
//  Color.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/12.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

public extension Color {
    /// 一位
    static let gold: Color          = Color(hex: "FFD700")
    /// 二位
    static let silver: Color        = Color(hex: "C0C0C0")
    /// 三位
    static let bronze: Color        = Color(hex: "CD7F32")
    /// 四位
    static let sandyBrown: Color    = Color(hex: "DEB887")
    /// 五位
    static let burlyWood: Color     = Color(hex: "FF5733")
    /// 六位
    static let royalBlue: Color     = Color(hex: "4169E1")
    /// 七位
    static let dodgerBlue: Color    = Color(hex: "1E90FF")
    /// 八位
    static let deepSkyBlue: Color   = Color(hex: "00BFFF")
    
    static var allCases: [Color] {
        [.gold, .silver, .bronze, .deepSkyBlue, .dodgerBlue, ]
    }
}
