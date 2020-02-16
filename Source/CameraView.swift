//
//  CameraView.swift
//  CameraKit
//
//  Created by Nicolas Degen on 03.02.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import SwiftUI

public struct CameraView: UIViewRepresentable {
  var cameraManager: CameraManager
  
  public init(cameraManager: CameraManager) {
    self.cameraManager = cameraManager
  }
  
  public func makeUIView(context: Context) -> UIView {
    let view = UIView()
    view.backgroundColor = .white
    cameraManager.addPreviewLayer(view: view)
    return view
  }
  
  public func updateUIView(_ uiView: UIView, context: Context) {}
}
