//
//  AezakmiPhotoApp.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import SwiftUI
import FirebaseCore

@main
struct AezakmiPhotoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .background(.lightPurple)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        debugPrint("Configure Firebase!")
        
        return true
    }
}
