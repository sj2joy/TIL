//
//  AppDelegate.swift
//  Practice2
//
//  Created by mac on 2020/08/19.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        mainVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "person.circle"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "paperplane"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "bookmark"), tag: 2)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC, secondVC, thirdVC]
        window?.rootViewController = tabBarController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

