//
//  ControlViewController.swift
//  Practice3
//
//  Created by mac on 2020/08/21.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {
    
    let slider = UISlider()
    var sliderValue: Float { return self.slider.value }
    
    override func viewDidLoad() {
        // 슬라이더의 촤소값 / 최대값 설정
        slider.minimumValue = 0
        slider.maximumValue = 100
        // 슬라이더의 영역과 크가를 정의하고 루트 뷰에 추가한다.
        slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        view.addSubview(slider)
        preferredContentSize = CGSize(width: slider.frame.width,
                                      height: slider.frame.height+10)
    }
}
