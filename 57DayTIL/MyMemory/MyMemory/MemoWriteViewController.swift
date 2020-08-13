//
//  MemoWriteViewController.swift
//  MyMemory
//
//  Created by mac on 2020/08/13.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MemoWriteViewContrller: UIViewController {
    
    let imgView = UIImageView()
    let textView = UITextView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let titleTextfield = UITextField()
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Write"
        setupUI()
        
    }
    private func setupUI() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTabSaveButton(_:)))
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(didTabCameraButton(_:)))
        navigationItem.rightBarButtonItems = [cameraButton, saveButton]
        
        imgView.frame = CGRect(x: 16, y: 340, width: 340, height: 300)
        imgView.backgroundColor = .yellow
        view.addSubview(imgView)
                
        titleLabel.frame = CGRect(x: 16, y: view.safeAreaInsets.top + 90, width: 50, height: 30)
        titleLabel.text = "제목"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        
        titleTextfield.frame = CGRect(x: titleLabel.frame.maxX + 30, y: titleLabel.frame.minY, width: 200, height: 30)
        titleTextfield.placeholder = "제목을 입력해 주세요"
        titleTextfield.textAlignment = .center
        titleTextfield.borderStyle = .line
        view.addSubview(titleTextfield)
        
        contentLabel.frame = CGRect(x: 16, y: titleLabel.frame.maxY + 20, width: 50, height: 30)
        contentLabel.text = "내용"
        view.addSubview(contentLabel)
        
        contentTextView.frame = CGRect(x: 16, y: contentLabel.frame.maxY + 20, width: 340, height: 140)
        contentTextView.backgroundColor = .red
        view.addSubview(contentTextView)
    }
    
    
    @objc private func didTabSaveButton(_ sender: UIBarButtonItem) {
        
    }
    @objc private func didTabCameraButton(_ sender: UIBarButtonItem) {
        
    }
}
