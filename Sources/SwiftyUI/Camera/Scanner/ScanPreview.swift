//
//  SwiftUIView.swift
//  
//
//  Created by devonly on 2021/10/29.
//

import SwiftUI
import AVFoundation

public class ScanPreview: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session: AVCaptureSession = AVCaptureSession()
    weak var delegate: QRCodeDelegate?
    
    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = self.bounds
    }
}
