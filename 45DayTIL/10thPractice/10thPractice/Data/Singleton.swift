//
//  SingleTon.swift
//  10thPractice
//
//  Created by mac on 2020/06/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import Foundation

final class Singleton {
    static let shared = Singleton()
    private init() {}
    
    var wishListDict: [String: Int] = [:]
}
