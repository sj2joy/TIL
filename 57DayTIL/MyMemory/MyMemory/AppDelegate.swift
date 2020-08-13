//
//  AppDelegate.swift
//  MyMemory
//
//  Created by mac on 2020/08/13.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        var memoList = [MemoData]()
        let mainVC = MainViewController()
        let naviVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()
        return true
    }
}
