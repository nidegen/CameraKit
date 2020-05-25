//
//  ContentView.swift
//  Example
//
//  Created by Nicolas Degen on 25.05.20.
//  Copyright © 2020 Nicolas Degen. All rights reserved.
//

import SwiftUI
import CameraKit

struct ContentView: View {
  var cameraManager: CameraManager
  
  var body: some View {
    CameraView(cameraManager: cameraManager)
      .onQRStringDetected { qrString in
        print(qrString)
      }
      .onAppear {
        self.cameraManager.startCamera()
      }
      .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(cameraManager: CameraManager())
  }
}
