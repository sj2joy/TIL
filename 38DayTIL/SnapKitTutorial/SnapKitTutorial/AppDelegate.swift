//
//  AppDelegate.swift
//  SnapKitTutorial
//
//  Created by mac on 2020/06/09.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let naviVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()

        return true
    }
}

