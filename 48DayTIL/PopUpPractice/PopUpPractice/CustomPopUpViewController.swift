//
//  CustomPopUpViewController.swift
//  PopUpPractice
//
//  Created by mac on 2020/06/29.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class CustomPopUpViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var bgBtn: UIButton!
    
    var likeBtnCompletionClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 30
        likeBtn.layer.cornerRadius = 10
        
    }
    @IBAction func onBgBtnClicked(_ sender: UIButton) {
        print("onBgBtnClicked")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onLikeBtnClicked(_ sender: UIButton) {
        print("onLikeBtnClicked")
        self.dismiss(animated: true, completion: nil)
        //컴플레션 블럭 호출
        if let likeBtnCompletionClosure = likeBtnCompletionClosure {
            likeBtnCompletionClosure()
        }
        
    }
}
