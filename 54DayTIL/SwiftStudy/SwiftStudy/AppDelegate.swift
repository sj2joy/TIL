//
//  AppDelegate.swift
//  SwiftStudy
//
//  Created by mac on 2020/07/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        let mainVC = MainViewController()
        let naviVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
