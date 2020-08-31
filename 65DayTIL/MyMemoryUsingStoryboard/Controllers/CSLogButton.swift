//
//  CSLogButton.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/22.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

public enum CSLogType: Int {
    case basic
    case title
    case tag
}

public class CSLogButton: UIButton {
    
    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tintColor = UIColor.white
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    @objc func logging(_ sender: UIButton) {
        switch self.logType {
        case .basic:
            NSLog ("버튼이 클릭되었습니다")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle) 버튼이클릭되었습니다")
        case .tag:
            NSLog("\(sender.tag)버튼이 클릭되었습니다.")
        }
    }
}
