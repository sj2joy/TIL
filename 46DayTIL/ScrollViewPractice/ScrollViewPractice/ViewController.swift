//
//  ViewController.swift
//  ScrollViewPractice
//
//  Created by mac on 2020/06/20.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    var images = [
        "image1.jpg",
        "image2.jpg",
        "image3.jpg",
        "image4.jpg"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        autoLayout()
    }
    private func autoLayout() {
        for i in 0..<images.count{
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            imageView.contentMode = .scaleAspectFit     //사진의 비율을 맞게 함
            let xPosition = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition,
                                     y: 0,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height)    //이미지 뷰가 화면 전체를 덮음
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1+i)
            scrollView.addSubview(imageView)
        }
    }
    private func setupUI() {
        scrollView.isPagingEnabled = true
        scrollView.frame = view.frame
        view.addSubview(scrollView)
    }
}

