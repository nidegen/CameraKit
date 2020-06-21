//
//  CameraPreviewWrapper.swift
//  CameraKit
//
//  Created by Nicolas Degen on 03.02.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import SwiftUI

public struct CameraPreviewWrapper: UIViewControllerRepresentable {
  
  public let cameraManager: CameraManager
  
  public typealias UIViewControllerType = CameraViewController
  
  public init(cameraManager: CameraManager) {
    self.cameraManager = cameraManager
  }
  
  public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraPreviewWrapper>) -> CameraViewController {
    
    let vc = CameraViewController()
    vc.cameraManager = self.cameraManager
    return vc
  }
  
  public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraPreviewWrapper>) {}
}

