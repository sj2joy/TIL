//
//  ListViewController.swift
//  Practice6 CustomPropertyList
//
//  Created by mac on 2020/08/24.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        
        let value = sender.selectedSegmentIndex
        
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        let customPlist = "\(self.account.text!).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist = \(plist)")
    }
    
    var accountlist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.delegate = self
        self.account.inputView = picker
        
        let plist = UserDefaults.standard
        self.name.text = plist.string(forKey: "name")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.married.isOn = plist.bool(forKey: "married")
        setupUI()
        
        let accountlist = plist.array(forKey:"accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        if let account = plist.string(forKey:"selectedAccount") {
            self.account.text = account
            
            let customPlist = "\(account).plist"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let plist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: plist)
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
        //비어있는 계정값 등록막을 때
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
    }
    
    private func setupUI() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x:0, y:0, width:0, height:35)
        toolbar.barTintColor = UIColor.lightGray
        self.account.inputAccessoryView = toolbar
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil) // Done버튼을 오른쪽으로 밀기위해서 생성
        
        let doneBtn = UIBarButtonItem()
        doneBtn.title = "Done"
        doneBtn.target = self
        doneBtn.action = #selector(pickerDone(_:))
        
        let newBtn = UIBarButtonItem()
        newBtn.title = "New"
        newBtn.target = self
        newBtn.action = #selector(newAccount(_:))
        
        toolbar.setItems([newBtn ,flexSpace,doneBtn], animated: true)
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_ :)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    @objc private func newAccount(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        alert.addTextField() {
            $0.placeholder = "ex) abc@gmail.com"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            if let account = alert.textFields?[0].text {
                self.accountlist.append(account)
                self.account.text = account
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                //계정목록을 통째로 저장하는 1번째방법
                let plist = UserDefaults.standard
                plist.set(self.accountlist, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                //계정목록을 통째로 저장하는 2번째방법
                //                let plist = UserDefaults.standard
                //                var savedAccountlist = plist.array(forKey: "accuontlist") ?? [String]()
                //                savedAccountlist.append(account)
                //                plist.set(savedAccountlist, forKey: "accountlist")
                //                plist.synchronize()
                
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        })
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc private func pickerDone(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        if let _account = self.account.text {
            
            let customPlist = "\(_account).plist"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let plist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: plist)
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    //MARK: -   UITableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1  && (self.account.text?.isEmpty)! == false  {
            let alert = UIAlertController(title: nil,
                                          message: "이름을 입력하세요", preferredStyle: .alert)
            alert.addTextField() {
                $0.text = self.name.text
                alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                    let value = alert.textFields?[0].text
                    
                    let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .documentDirectory, .userDomainMask, true)
                    let path = paths[0] as NSString
                    let plist = path.strings(byAppendingPaths: [customPlist]).first!
                    let data = NSMutableDictionary(contentsOfFile:plist) ?? NSMutableDictionary()
                    
                    data.setValue(value, forKey: "name")
                    data.write(toFile: plist, atomically: true)
                    
                    self.name.text = value
                })
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
}
//MARK: - UIPickerViewDataSource
extension ListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let account = self.accountlist[row]
        self.account.text = account
        
        //사용자가 계정을 생성했을 때 이 계정이 선택되는 것으로 저장하는
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
        
    }
}

//MARK: - UIPickerViewDelegate

extension ListViewController: UIPickerViewDelegate {
    
}
