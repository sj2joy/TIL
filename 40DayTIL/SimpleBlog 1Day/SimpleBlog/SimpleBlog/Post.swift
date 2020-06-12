//
//  Post.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/10.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import Foundation

//데이터 클래스
struct Post {
    
    let title: String
    let body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
