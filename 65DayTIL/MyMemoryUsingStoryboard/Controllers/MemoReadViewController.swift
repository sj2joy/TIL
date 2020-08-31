//
//  MemoReadViewController.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MemoReadViewController: UIViewController {

    var param: MemoData?
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subject?.text = param?.title
        self.contents?.text = param?.contents
        self.img?.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        self.navigationItem.title = dateString
    }

}
