//
//  SecondViewController.swift
//  NavigationControllerExample


import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        title = "SecondVC"
        navigationItem.title = "SecondVC"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.popViewController(animated: true) //viewDidAppear에서 실행하면 바로 첫화면으로 돌아감
        //navigationController?.popToRootViewController(animated: true) //stack이 제거된 첫번째 루트뷰로 가게됨
    }
}

