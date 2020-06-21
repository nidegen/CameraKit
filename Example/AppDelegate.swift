//
//  AppDelegate.swift
//  Example
//
//  Created by Nicolas Degen on 03.03.19.
//  Copyright © 2019 Nicolas Degen. All rights reserved.
//

import UIKit
import SwiftUI

import CameraKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var cameraManager = CameraManager()
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    
//    let vc = ViewController()
//    vc.cameraManager = cameraManager
//    window!.rootViewController = vc
    window!.rootViewController = UIHostingController(rootView: ContentView(cameraManager: cameraManager))
    
    
    window!.makeKeyAndVisible()
    
    return true
  }
}
