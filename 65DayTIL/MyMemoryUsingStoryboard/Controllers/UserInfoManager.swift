//
//  UserInfoManager.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/25.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit


struct UserInfoKey {
    
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL"
    
}

class UserInfoManager {
    var loginId: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    var accout: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile) }
            else {
                return UIImage(named: "account.jpg")
                
            }
        }
        set(value) {
            if value != nil {
                let ud = UserDefaults.standard
                ud.set(value!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    var isLogin: Bool {
        if self.loginId == 0 || self.accout == nil {
            return false
        } else {
            return true
        }
    }
    
    func login(account: String, password: String) -> Bool {
        
        if account.isEqual("sj2joy@naver.com") && password.isEqual("sj2joy") {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("석진", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
            
        } else{
            return false
        }
    }
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}

