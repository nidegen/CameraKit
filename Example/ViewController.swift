//
//  ViewController.swift
//  Example
//
//  Created by Nicolas Degen on 03.03.19.
//  Copyright © 2019 Nicolas Degen. All rights reserved.
//

import UIKit
import AVKit

import CameraKit

class ViewController: UIViewController {
  var cameraManager: CameraManager!
  let photoButton = UIButton(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(photoButton)
    photoButton.translatesAutoresizingMaskIntoConstraints = false
    photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    photoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    photoButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    photoButton.heightAnchor.constraint(equalTo: photoButton.widthAnchor).isActive = true
    
    photoButton.layer.cornerRadius = 30
    photoButton.clipsToBounds = true
    photoButton.backgroundColor = .white
    photoButton.addTarget(self, action: #selector(capturePhoto(_:)), for: .touchDown)
    
    
    cameraManager.metaDataOutputDelegate = self
    cameraManager.sampleBufferOutputDelegate = self
    cameraManager.setupCamera()
    cameraManager.addPreviewLayer(view: view)
    cameraManager.startCamera()
  }
}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    if metadataObjects.count == 0 {
      return
    }
    
    // Get the metadata object.
    if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
      if metadataObj.type == AVMetadataObject.ObjectType.qr {
        let qrString = metadataObj.stringValue ?? ""
        print(qrString)
      }
    }
  }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//    print("received frame")
  }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    
    guard let data = photo.fileDataRepresentation(),
      let image =  UIImage(data: data)  else {
        return
    }
    print("captured an image of size \(image.size)")
  }
  
  @objc func capturePhoto(_ sender: UIButton) {
    let photoSettings = AVCapturePhotoSettings()
    photoSettings.isHighResolutionPhotoEnabled = true
    photoSettings.flashMode = .auto
    
    if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
      photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
    }
    
    cameraManager.photoOutput.capturePhoto(with: photoSettings, delegate: self)
  }
}
