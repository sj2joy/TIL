//
//  Utils.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/31.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ message: String, completion: (()-> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
    
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
