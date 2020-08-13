//
//  CustomCellUI.swift
//  MyMemory
//
//  Created by mac on 2020/08/13.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class CustomCellUI {
    func setupEvenCellUI() {
        
    }
    
    func setupOddCellUI() {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 50, y: 10, width: 150, height: 20)
        titleLabel.backgroundColor = .yellow
        titleLabel.text = "글의 제목"
        
    }
}
