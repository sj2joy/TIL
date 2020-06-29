//
//  ViewController.swift
//  PopUpPractice
//
//  Created by mac on 2020/06/29.
//  Copyright © 2020 Seokjin. All rights reserved.
//
 

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet weak var createPopUpBtn: UIButton!
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTabButton(_ sender: UIButton) {
        print("Clicked")
        let storyboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        let customPopUpVC = storyboard.instantiateViewController(withIdentifier: "AlertPopUpVC") as! CustomPopUpViewController
        //뷰컨트롤러가 보여지는스타일
        customPopUpVC.modalPresentationStyle = .overCurrentContext
        //뷰컨트롤러가 사라지는 스타일
        customPopUpVC.modalTransitionStyle = .crossDissolve
        
        customPopUpVC.likeBtnCompletionClosure = {
            print("컴플레션 블락 호출됨")
            let myChannelUrl = URL(string: "https://naver.com")
            self.myWebView.load(URLRequest(url: myChannelUrl!))
        }
        
        self.present(customPopUpVC, animated: true, completion: nil)
    }

}
