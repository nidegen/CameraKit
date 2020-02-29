//
//  CameraView.swift
//  CameraKit
//
//  Created by Nicolas Degen on 03.02.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct CameraView: UIViewControllerRepresentable {
  
  public let cameraManager: CameraManager
  
  public typealias UIViewControllerType = CameraViewController
  
  public init(cameraManager: CameraManager) {
    self.cameraManager = cameraManager
  }
  
  public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> CameraViewController {
    
    let vc = CameraViewController()
    vc.cameraManager = self.cameraManager
    return vc
  }
  
  public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraView>) {}
}

