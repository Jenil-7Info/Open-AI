//
//  AppDelegate.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 01/05/23.
//

import Firebase
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
