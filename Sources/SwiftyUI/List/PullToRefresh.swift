//
//  PullToRefresh.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import SwiftUI

//private struct PullToRefresh: UIViewRepresentable {
//    
//    @Binding var isShowing: Bool
//    let onRefresh: () -> Void
//    
//    public init(
//        isShowing: Binding<Bool>,
//        onRefresh: @escaping () -> Void
//    ) {
//        _isShowing = isShowing
//        self.onRefresh = onRefresh
//    }
//    
//    public class Coordinator {
//        let onRefresh: () -> Void
//        let isShowing: Binding<Bool>
//        
//        init(
//            onRefresh: @escaping () -> Void,
//            isShowing: Binding<Bool>
//        ) {
//            self.onRefresh = onRefresh
//            self.isShowing = isShowing
//        }
//        
//        @objc func onValueChanged() {
//            isShowing.wrappedValue.toggle()
//            onRefresh()
//        }
//    }
//    
//    public func makeUIView(context: UIViewRepresentableContext<PullToRefresh>) -> UITableView {
//        return UITableView(frame: .zero)
//    }
//
//    public func updateUIView(_ uiView: UITableView, context: UIViewRepresentableContext<PullToRefresh>) {
//        
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            
//            guard let tableView = uiView.superview?.findSiblings(containing: UIScrollView.self) else {
//                return
//            }
//            
////            guard let tableView = uiView.superview?.findSiblings(containing: UITableView.self) else {
////                return
////            }
//            
//            if let refreshControl = tableView.refreshControl {
//                if self.isShowing {
//                    refreshControl.beginRefreshing()
//                } else {
//                    refreshControl.endRefreshing()
//                }
//                return
//            } else {
//                let refreshControl = UIRefreshControl()
//                refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
//                tableView.refreshControl = refreshControl
//            }
//        }
//    }
//    
//    public func makeCoordinator() -> Coordinator {
//        return Coordinator(onRefresh: onRefresh, isShowing: $isShowing)
//    }
//}
//
//extension View {
//    public func pullToRefresh(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
//        return overlay(
//            PullToRefresh(isShowing: isShowing, onRefresh: onRefresh)
//                .frame(width: 0, height: 0)
//        )
//    }
//}
