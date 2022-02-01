//
//  ShareSheet.swift
//  
//
//  Created by devonly on 2021/12/12.
//

import Foundation
import SwiftUI

public extension View {
    func presentShareSheet(isPresented: Binding<Bool>, type: ActivityType) -> some View {
        self.overlay(
            ShareSheet(isPresented: isPresented, activityItems: type.items)
                .frame(width: 0, height: 0)
        )
    }
}

public enum ActivityType {
    case photo(UIImage)
    case movie(Data)
    
    var items: [Any] {
        switch self {
            case .photo(let image):
                return [image]
            case .movie(let data):
                return []
            default:
                return []
        }
    }
}

extension UIActivity.ActivityType {
    static let reminders = UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension")
}

struct ShareSheet: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let activity: UIActivityViewController
    
    init(isPresented: Binding<Bool>, activityItems: [Any]) {
        self._isPresented = isPresented
        self.activity = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.activity.excludedActivityTypes = [
            .assignToContact,
            .print,
            UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension")]
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        ViewController(coordinator: context.coordinator)
    }
    
    // isPresentedの値が変わったときに呼ばれる
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//        context.coordinator.parent = self
//        uiViewController.parent?.presentationController?.delegate = context.coordinator
        // 大事
        activity.presentationController?.delegate = context.coordinator
//        activity.popoverPresentationController?.delegate = context.coordinator
//        activity.popoverPresentationController?.backgroundColor = .blue
        
        switch isPresented {
            case true:
                uiViewController.present(activity, animated: true, completion: nil)
            case false:
//                activity.dismiss(animated: true, completion: nil)
                uiViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    class ViewController: UIViewController {
        let coordinator: ShareSheet.Coordinator
        
        init(coordinator: ShareSheet.Coordinator) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: .main)
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate, UIPopoverPresentationControllerDelegate {
        var parent: ShareSheet
        
        init(_ parent: ShareSheet) {
            self.parent = parent
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            print("WillDismiss")
        }
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            print("DidAttemptToDismiss")
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            if parent.isPresented {
                parent.isPresented.toggle()
            }
        }
    }
}
