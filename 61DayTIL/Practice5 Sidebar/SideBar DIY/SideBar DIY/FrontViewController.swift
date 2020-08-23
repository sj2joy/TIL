//
//  FrontViewController.swift
//  SideBar DIY
//
//  Created by mac on 2020/08/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* 폰으로 드래그 제스쳐로 사이드바 열고 닫게 할 수있도록 하는 명령어
         
        let dragLeft = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(moveSideBtn(_:)))
        dragLeft.edges = UIRectEdge.left // 시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) // 뷰에 제스처 객체 등록
        
        let dragRight = UISwipeGestureRecognizer(
            target: self,
            action: #selector(moveSideBtn(_:)))
            dragRight.direction = .left // 방향은 왼쪽
        self.view.addGestureRecognizer(dragRight) */
        setupUI()
    }
    private func setupUI() {
        let sideBarBtn = UIBarButtonItem(image: UIImage(named: "sidemenu.png"),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(moveSideBtn(_:)))
        self.navigationItem.leftBarButtonItem = sideBarBtn
    }
    @objc func moveSideBtn(_ sender: UIButton) {
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openSideBar(nil) // 사이드 바를 연다.
        } else {
            self.delegate?.closeSideBar(nil)// 사이드 바를 닫는다.
        }
    }
}
