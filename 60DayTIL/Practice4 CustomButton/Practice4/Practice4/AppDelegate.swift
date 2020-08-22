//
//  AppDelegate.swift
//  Practice4
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        let naviVC = UINavigationController(rootViewController: mainVC)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        return true
    }
    
}
