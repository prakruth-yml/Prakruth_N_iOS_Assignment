//
//  AppDelegate.swift
//  AgileSrintPlanner
//
//  Created by Prakruth Nagaraj on 30/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
//        let authUI = FUIAuth.defaultAuthUI()
//        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
//        authUI?.providers = providers
//        authUI?.delegate = self
//        
//        guard let authVC = authUI?.authViewController() else { return true }
//        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = authVC
//        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
