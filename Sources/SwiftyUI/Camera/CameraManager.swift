//
//  CameraManager.swift
//  
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import UIKit
import AVFoundation
import SwiftUI

class CameraManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate, ObservableObject {
    @Published var image: UIImage?
    @Published var orientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .portrait
    
    public var captureSession: AVCaptureSession
    private var videoDevice: AVCaptureDevice?
    private var videoOutput: AVCaptureVideoDataOutput
    private var photoOutput: AVCapturePhotoOutput
    private var metadataOutput: AVCaptureMetadataOutput
    private let queue: DispatchQueue = DispatchQueue(label: "Camera View", attributes: .concurrent)
    private let cameraMode: CameraMode
    public var onResult: (String) -> Void = { _ in }
    
    public init(
        deviceType: AVCaptureDevice.DeviceType,
        mediaType: AVMediaType?,
        position: AVCaptureDevice.Position = .front,
        cameraMode: CameraMode = .video
    ) {
        self.captureSession = AVCaptureSession()
        self.photoOutput = AVCapturePhotoOutput()
        self.videoOutput = AVCaptureVideoDataOutput()
        self.metadataOutput = AVCaptureMetadataOutput()
        self.cameraMode = cameraMode
        super.init()
        #if targetEnvironment(simulator)
            NotificationCenter.default.post(name: .AVCaptureMetadataDetect, object: "0A378437BF3499349941F55402306131")
        #else
        // If avaialble camera access
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setupCaptureSession(deviceType: deviceType, mediaType: mediaType, position: position, cameraMode: cameraMode)
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                    if granted {
                        self.setupCaptureSession(deviceType: deviceType, mediaType: mediaType, position: position, cameraMode: cameraMode)
                    }
                })
            case .denied:
                return
            case .restricted:
                return
            @unknown default:
                return
        }
        #endif
    }
    
    /// カメラデバイスを設定する
    private func setupCaptureSession(deviceType: AVCaptureDevice.DeviceType, mediaType: AVMediaType?,  position: AVCaptureDevice.Position, cameraMode: CameraMode) {
        videoDevice = AVCaptureDevice.default(deviceType, for: mediaType, position: position)
        captureSession.beginConfiguration()
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice!) as AVCaptureDeviceInput
            captureSession.addInput(videoInput)
        } catch let error as NSError {
            print(error)
        }
        
        // 入力モードによって切り替える
        switch cameraMode {
            case .video:
                if captureSession.canAddOutput(videoOutput) {
                    videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String : Int(kCVPixelFormatType_32BGRA)]
                    videoOutput.setSampleBufferDelegate(self, queue: queue)
                    videoOutput.alwaysDiscardsLateVideoFrames = true
                    captureSession.addOutput(videoOutput)
                }
            case .photo:
                if captureSession.canAddOutput(photoOutput) {
                    captureSession.addOutput(photoOutput)
                }
            case .scan:
                if captureSession.canAddOutput(metadataOutput) {
                    captureSession.addOutput(metadataOutput)
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.qr]
                }
        }
        // 常にPhotoモードで良い？
        captureSession.sessionPreset = .photo
        captureSession.commitConfiguration()
    }
    
    /// セッションを開始する
    public func setupSession() {
        #if targetEnvironment(simulator)
        #else
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            updateInputOrientation()
            captureSession.startRunning()
        }
        #endif
    }
    
    /// セッションを閉じる
    public func endSession() {
        #if targetEnvironment(simulator)
        #else
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            captureSession.stopRunning()
        }
        #endif
    }
    
    /// フロントカメラとバックカメラを切り替える
    public func changeCameraPosition() {
        #if targetEnvironment(simulator)
        #else
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            captureSession.stopRunning()
            // セッションをすべて閉じてからビデオデバイスを切り替えて再起動
            captureSession.inputs.forEach { input in
                self.captureSession.removeInput(input)
            }
            captureSession.outputs.forEach { output in
                self.captureSession.removeOutput(output)
            }
            if let videoDevice = videoDevice {
                let position: AVCaptureDevice.Position = videoDevice.position == .front ? .back : .front
                let deviceType: AVCaptureDevice.DeviceType = videoDevice.deviceType
                let mediaType: AVMediaType? = .video
                setupCaptureSession(deviceType: deviceType, mediaType: mediaType, position: position, cameraMode: cameraMode)
                setupSession()
            }
        }
        #endif
    }
    
    /// カメラの入力画像の傾きを変更
    private func updateInputOrientation() {
        #if targetEnvironment(simulator)
        #else
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            for conn in self.captureSession.connections {
                if conn.isVideoOrientationSupported {
                    conn.videoOrientation = .portrait
                }
            }
        }
        #endif
    }
    
    /// Metadataを見つけたときに呼ばれる
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        /// Metadataを読み込んで通知を送ったあと、セッションを終了
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let qrcode = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            NotificationCenter.default.post(name: .AVCaptureMetadataDetect, object: qrcode)
            captureSession.stopRunning()
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {
        let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let baseAddress = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        let imageRef = context!.makeImage()
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let resultImage: UIImage = UIImage(cgImage: imageRef!)
        return resultImage
    }
}


extension UIInterfaceOrientation {
    var degree: Double {
        switch self {
            case .landscapeLeft:
                return 90
            case .landscapeRight:
                return -90
            case .portrait:
                return 0
            case .portraitUpsideDown:
                return 180
            case .unknown:
                return 0
            @unknown default:
                fatalError()
        }
    }
}

public enum CameraMode: Int, CaseIterable {
    case video
    case photo
    case scan
}

public extension Notification.Name {
    static let AVCaptureMetadataDetect = Notification.Name("AVCaptureMetadataDetect")
}
