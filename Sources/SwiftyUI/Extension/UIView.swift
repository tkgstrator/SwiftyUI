//
//  UIView.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import UIKit

//extension UIView {
//    /// SuperViewを検索するメソッド
//    @usableFromInline
//    func findHostView(from entry: UIView) -> UIView? {
//        if let superview = self.superview {
//            if NSStringFromClass(type(of: superview)).contains("ViewHost") {
//                return superview
//            } else {
//                return superview.findHostView(from: entry)
//            }
//        }
//        return nil
//    }
//    
//    /// 兄弟のビューを検索するメソッド
//    @usableFromInline
//    func findSiblings<ViewType: UIView>(containing type: ViewType.Type) -> ViewType? {
//        guard let superview = self.superview, let entryIndex = superview.subviews.firstIndex(of: self), entryIndex > 0 else {
//            return nil
//        }
//
//        for subview in superview.subviews[0..<entryIndex].reversed() {
//            if let matchview = ([subview] + subview.subviews).compactMap({ $0 as? ViewType }).first {
//                return matchview
//            }
//        }
//        return nil
//    }
//}
