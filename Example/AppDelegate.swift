//
//  AppDelegate.swift
//  Example
//
//  Created by Nicolas Degen on 03.03.19.
//  Copyright © 2019 Nicolas Degen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window!.rootViewController = ViewController()
    window!.makeKeyAndVisible()
    
    return true
  }
}
