//
//  ViewController.swift
//  10thPractice
//
//  Created by mac on 2020/06/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sectionVC = UINavigationController(rootViewController: SectionViewController())
        let wishListVC = UINavigationController(rootViewController: WishListViewController())
        
        sectionVC.tabBarItem = UITabBarItem(title: "Section", image: nil, tag: 0)
        wishListVC.tabBarItem = UITabBarItem(title: "WishList", image: nil, tag: 0)
        
        viewControllers = [sectionVC, wishListVC]
        
    }
}

