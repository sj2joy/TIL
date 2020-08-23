//
//  FrontViewController.swift
//  Practice5 Side Bar
//
//  Created by mac on 2020/08/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    
    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let revealVC = revealViewController() {
            sideBarButton.target = revealVC
            sideBarButton.action = #selector(revealVC.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer()) //스와이프 제스쳐로 사이드바를 열었다 닫았다 할 수 있게 하는
        }
    }
}
