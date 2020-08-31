//
//  TutorialContentsVC.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/31.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class TutorialContentsVC: UIViewController {
      
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        self.bgImageView.image = UIImage(named: self.imageFile)
    }
}
