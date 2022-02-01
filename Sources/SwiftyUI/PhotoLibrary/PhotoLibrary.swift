//
//  PhotoLibrary.swift
//  
//
//  Created by devonly on 2022/01/23.
//

import Foundation
import SwiftUI

public struct PhotoLibrary: UIViewControllerRepresentable {
    // MARK: - Working with UIViewControllerRepresentable
    public var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    public init(sourceType: UIImagePickerController.SourceType, selectedImage: Binding<UIImage?>) {
        self.sourceType = sourceType
        self._selectedImage = selectedImage
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoLibrary>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator  // Coordinater to adopt UIImagePickerControllerDelegate Protcol.
        return imagePicker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoLibrary>) {
    }
    
    // MARK: - Using Coordinator to Adopt the UIImagePickerControllerDelegate Protocol
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: PhotoLibrary
        
        init(_ parent: PhotoLibrary) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
