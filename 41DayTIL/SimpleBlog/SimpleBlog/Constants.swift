//
//  Constants.swift
//  SimpleBlog
//
//  Created by mac on 2020/06/11.
//  Copyright © 2020 Seokjin. All rights reserved.
//

struct Constants {
    static let API_BASE_URL: String = "http://13.209.73.176/api/"
    
    struct API {
        static let GET_POSTS: String = "\(API_BASE_URL)post"
    }
}
enum ConstantsEnum {
    static let API_BASE_URL: String = "http://13.209.73.176/api/"
    enum API {
        static let GET_POSTS: String = "\(API_BASE_URL)post"
    }
}
