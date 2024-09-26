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
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let firebaseConfigs = FirebaseApp.configure()
    var firebase = FirebaseManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        if let role = UserDefaults.standard.object(forKey: Constants.UserDefaults.role) as? String {
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ProductOwnerMainVC.self)) as? ProductOwnerMainVC else { return true }
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        else {
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else { return true }
            window?.rootViewController = viewController
        }
        return true
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
