//
//  CameraViewController.swift
//  CameraKit
//
//  Created by Nicolas Degen on 29.02.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import UIKit

public class CameraViewController: UIViewController {
  
  public var cameraManager: CameraManager?
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    cameraManager.map {
      $0.addPreviewLayer(view: self.view)
    }
  }
}
