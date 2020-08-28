//
//  ViewController.swift
//  Practice8 API
//
//  Created by mac on 2020/08/28.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var responseView: UITextView!
    
    
    @IBAction func post(_ sender: UIButton) {
        
        let userId = (self.userId.text)!
        let name = (self.name.text)!
        let param = ["userId" : userId,"name" : name]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
//        let task = URLSession.shared.dataTask(with: request) 응답값이 필요없을 경우엔 이렇게만 써도 됨
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let e = error {
                NSLog("An error has occurred: \(e.localizedDescription)")
                return
            }
            DispatchQueue.main.async() {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    let result      = jsonObject["result"] as? String
                    let timestamp   = jsonObject["timestamp"] as? String
                    let userId      = jsonObject["userId"] as? String
                    let name        = jsonObject["name"] as? String
                    
                    if result == "SUCCESS" {
                        self.responseView.text = "아이디 : \(userId!)" + "\n"
                        + "이름 : \(name!)" + "\n"
                        + "응답결과 : \(result!)" + "\n"
                        + "응답시간 : \(timestamp!)" + "\n"
                        + "요청방식 : x-www-form-urlencoded"
                    }
//                    print ("Response Data=\(String(data: data!, encoding: .utf8)!)")
                }catch let e as NSError {
                    print("An error has occurred while parsing JSONObject : \(e.localizedDescription)")
                }
            }
        }
        task.resume()
}
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBAction func callCurrentTime(_ sender: UIButton) {
        do {
            
            let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
            let response = try String(contentsOf: url!)
            currentTimeLabel.text = response
            currentTimeLabel.sizeToFit()
        } catch let e as NSError {
            
            print(e.localizedDescription)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

