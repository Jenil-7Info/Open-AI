//
//  OpenArtificial_intelligenceApp.swift
//  OpenArtificial intelligence
//
//  Created by SevenInfosystem on 13/01/23.
//

import SwiftUI
import Firebase

@main
struct OpenArtificial_intelligenceApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            OpenAIRootView()
        }
    }
}

