//
//  CameraPreview.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

struct CameraPreview: UIViewRepresentable {
    let previewFrame: CGRect
    let capture: CameraManager
    
    func makeUIView(context: Context) -> UICameraView {
        let view = UICameraView(frame: previewFrame, session: self.capture.captureSession)
        view.setupPreview(previewSize: previewFrame)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.updateFrame(frame: previewFrame)
    }
}
