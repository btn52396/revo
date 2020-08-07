//
//  AppDelegate.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/3/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = UINavigationController(rootViewController: HomeViewController())
        root.modalPresentationStyle = .fullScreen
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }

}

