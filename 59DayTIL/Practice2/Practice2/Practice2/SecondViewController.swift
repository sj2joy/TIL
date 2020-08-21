//
//  SecondViewController.swift
//  Practice2
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupUI()
    }
    private func setupUI() {
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "두 번째 랩"
        title.textAlignment = .center
        title.sizeToFit()
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.center.x = view.frame.width / 2
        self.view.addSubview(title)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = tabBarController?.tabBar
        tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        //            UIView.animate(withDuration: (0.15)) {
        //                tabBar?.alpha = (tabBar?.alpha == 0) ? 1 : 0
    }
}
