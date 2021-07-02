//
//  HarvestAppApp.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI
import Firebase
import FBSDKLoginKit


@main
struct HarvestAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


// Swift // // SceneDelegate.swift import FBSDKCoreKit ... func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) { guard let url = URLContexts.first?.url else { return } ApplicationDelegate.shared.application( UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation] ) }

    
