//
//  CameraView.swift
//
//  SwiftyUI
//  Created by devonly on 2021/08/27.
//  
//  Magi Corporation, All rights, reserved.

import Foundation
import SwiftUI

public struct CameraView: View {
    @StateObject var capture: CameraManager
    @Environment(\.presentationMode) var presentationMode
    @State var rotation: Double = 0.0

    public init(cameraMode: CameraMode) {
        self._capture = StateObject(wrappedValue: CameraManager(deviceType: .builtInWideAngleCamera, mediaType: .video, position: .back, cameraMode: cameraMode))
    }
    
    public var body: some View {
        GeometryReader { geometry in
            CameraPreview(previewFrame: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height), capture: capture)
                .onAppear(perform: capture.setupSession)
                .onDisappear(perform: capture.endSession)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { value in
                    if let orientation: UIInterfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
                        withAnimation(nil) {
                            rotation = orientation.degree
                        }
                    }
                })
                .rotationEffect(.degrees(rotation))
        }
        .onReceive(NotificationCenter.default.publisher(for: .AVCaptureMetadataDetect)) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }
}
