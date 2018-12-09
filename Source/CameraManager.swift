//
//  CameraManager.swift
//  CameraKit
//
//  Created by Nicolas Degen on 24.10.18.
//  Copyright © 2018 Nicolas Degen. All rights reserved.
//

import AVFoundation
import CoreImage

public class CameraManager {
  // MARK: - Properties
  
  lazy var captureSession: AVCaptureSession = {
    let session = AVCaptureSession()
    session.sessionPreset = .high
    return session
  }()
  
  let cameraQueue = DispatchQueue.global(qos: .userInteractive)
  var sampleBufferOutputDelegate: AVCaptureVideoDataOutputSampleBufferDelegate?
  var metaDataOutputDelegate: AVCaptureMetadataOutputObjectsDelegate?
  
  public init(sampleBufferOutputDelegate: AVCaptureVideoDataOutputSampleBufferDelegate) {
    self.sampleBufferOutputDelegate = sampleBufferOutputDelegate
  }
  
  public init(metaDataOutputdelegate: AVCaptureMetadataOutputObjectsDelegate) {
    self.metaDataOutputDelegate = metaDataOutputdelegate
  }
  
  public init(sampleBufferOutputDelegate: AVCaptureVideoDataOutputSampleBufferDelegate, metaDataOutputdelegate: AVCaptureMetadataOutputObjectsDelegate) {
    self.sampleBufferOutputDelegate = sampleBufferOutputDelegate
    self.metaDataOutputDelegate = metaDataOutputdelegate
  }
  
  public func setupCamera() {
    if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
      setupCaptureSession()
    } else {
      AVCaptureDevice.requestAccess(for: .video, completionHandler: { (authorized) in
        DispatchQueue.main.async {
          if authorized {
            self.setupCaptureSession()
          }
        }
      })
    }
  }
  
  public func startCamera() {
    if !captureSession.isRunning {
      captureSession.startRunning()
    }
  }
  
  public func stopCamera() {
    if captureSession.isRunning {
      captureSession.stopRunning()
    }
  }
  
  #if os(iOS)
  public func addPreviewLayer(view: UIView) {
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.bounds
    previewLayer.backgroundColor = UIColor.black.cgColor
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.insertSublayer(previewLayer, at: 0)
  }
  #endif
  
  // MARK: - Camera Capture
  
  private func findCamera() -> AVCaptureDevice? {
    #if os(iOS)
    let deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera]
    let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .back)
    return discovery.devices.first
    #elseif os(macOS)
    return AVCaptureDevice.default(for: .video)
    #else
    print("OMG, it's that mythical new Apple product!!!")
    #endif
  }
  
  public func setupCaptureSession() {
    guard captureSession.inputs.isEmpty else { return }
    guard let camera = findCamera() else {
      print("No camera found")
      return
    }
    
    do {
      let cameraInput = try AVCaptureDeviceInput(device: camera)
      captureSession.addInput(cameraInput)
      
      if let sampleBufferOutputDelegate = self.sampleBufferOutputDelegate {
        let output = AVCaptureVideoDataOutput()
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(sampleBufferOutputDelegate, queue: cameraQueue)
        
        for pixelType in output.availableVideoPixelFormatTypes {
          if pixelType == kCVPixelFormatType_32BGRA {
            
          }
          if (pixelType == kCVPixelFormatType_32BGRA) || (pixelType == kCVPixelFormatType_32RGBA) {
            var videoSettings = [String : Any]()
            videoSettings[kCVPixelBufferPixelFormatTypeKey as String] =  pixelType
            output.videoSettings = videoSettings
            break
          }
        }
        captureSession.addOutput(output)
      }
      
      
      if let metaDataOutputDelegate = self.metaDataOutputDelegate {
        let metaDataOutput = AVCaptureMetadataOutput()
        metaDataOutput.setMetadataObjectsDelegate(metaDataOutputDelegate, queue: cameraQueue)
        metaDataOutput.metadataObjectTypes = metaDataOutput.availableMetadataObjectTypes
        captureSession.addOutput(metaDataOutput)
      }
      
    } catch let error {
      print("Error creating capture session: \(error)")
      return
    }
  }
}

