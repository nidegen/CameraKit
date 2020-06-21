//
//  CameraView.swift
//  CameraKit
//
//  Created by Nicolas Degen on 21.06.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import SwiftUI

import AVKit

public struct CameraView: View {
  @ObservedObject
  public var cameraManager: CameraManager
  
  public init(cameraManager: CameraManager) {
    self.cameraManager = cameraManager
  }
  
  public init() {
    self.cameraManager = CameraManager()
  }
  
  public var body: some View {
    Group {
      if cameraManager.cameraAccessGranted {
        CameraPreviewWrapper(cameraManager: cameraManager)
        .onAppear {
          self.cameraManager.startCamera()
        }
      } else {
        VStack {
          Text("Camera Access not yet granted").font(.subheadline)
          Button("Grant Access") {
            self.cameraManager.requestCameraAccess()
          }
          .font(.headline)
        }
      }
    }
  }
  
  public func onPhotoCaptured(perform action: ((AVCapturePhotoOutput, AVCapturePhoto, Error?) -> Void)? = nil) -> CameraView {
    self.cameraManager.onDidCapturePhoto = action
    return self
  }
  
  public func onQRStringDetected(perform action: ((String) -> Void)? = nil) -> CameraView {
    self.cameraManager.onDetectedQRString = action
    return self
  }
}

struct CameraView_Previews: PreviewProvider {
  static var previews: some View {
    CameraView(cameraManager: CameraManager())
  }
}
