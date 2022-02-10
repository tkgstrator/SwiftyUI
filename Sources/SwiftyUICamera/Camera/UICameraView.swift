//
//  UICameraView.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import AVFoundation
import UIKit

final class UICameraView: UIView {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init(frame: CGRect, session: AVCaptureSession) {
        self.captureSession = session
        super.init(frame: frame)
        addOrientationChangeDetector()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupPreview(previewSize: CGRect) {
        self.frame = previewSize
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = self.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.layer.addSublayer(previewLayer)
    }
    
    func updateFrame(frame: CGRect) {
        
    }
    
    private func addOrientationChangeDetector() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func orientationChanged() {
    }
    
    private func updatePreviewOrientation() {
    }
}
