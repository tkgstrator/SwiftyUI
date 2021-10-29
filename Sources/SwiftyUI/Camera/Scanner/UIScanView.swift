//
//  UIScanView.swift
//  
//
//  Created by devonly on 2021/10/29.
//

import SwiftUI
import AVFoundation

public struct ScanView: UIViewRepresentable {
    let supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    public typealias UIViewType = ScanPreview
    
    private let session: AVCaptureSession = AVCaptureSession()
    private let delegate: QRCodeDelegate = QRCodeDelegate()
    private let metadataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    public init() {}
    
    func setupCamera(_ uiView: ScanPreview) {
        guard let camera = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: camera) else { return }
        session.sessionPreset = .photo
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.metadataObjectTypes = supportedBarcodeTypes
            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        uiView.layer.addSublayer(previewLayer)
        uiView.previewLayer = previewLayer
        session.startRunning()
    }
    
    public func onResult(barcode: @escaping (String) -> Void) -> ScanView {
        delegate.onResult = barcode
        return self
    }
    
    public static func dismantleUIView(_ uiView: ScanPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }
    
    func checkCameraAuthorizationStatus(_ uiView: ScanPreview) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
            case .authorized:
                setupCamera(uiView)
            default:
                requestAuthorization(uiView)
        }
    }
    
    func requestAuthorization(_ uiView: ScanPreview) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            switch granted {
                case true:
                    setupCamera(uiView)
                case false:
                    break
            }
        })
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ScanView>) -> ScanView.UIViewType {
        let scanView = ScanPreview(session: session)
        checkCameraAuthorizationStatus(scanView)
        return scanView
    }
    
    public func updateUIView(_ uiView: ScanPreview, context: UIViewRepresentableContext<ScanView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
