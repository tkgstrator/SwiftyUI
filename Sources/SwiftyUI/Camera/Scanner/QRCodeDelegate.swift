//
//  QRCodeDelegate.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//
//  Magi Corporation, All rights, reserved.

import Foundation
import AVFoundation

class QRCodeDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var onResult: (String) -> Void = { _ in }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.onResult(stringValue)
        }
    }
}
