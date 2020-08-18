//
//  MemoFormViewController.swift
//  MyMemoryUsingStoryboard
//
//  Created by mac on 2020/08/18.
//  Copyright © 2020 Seokjin. All rights reserved.
//

import UIKit

class MemoFormViewController: UIViewController {

    var subject: String?

    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil,
                                          message: "내용을 입력해주세요",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pick(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        // Do any additional setup after loading the view.
    }

}

//MARK: - UIImagePickerControllerDelegate
extension MemoFormViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        picker.dismiss(animated: false, completion: nil)
    }
}


//MARK: - UINavigationControllerDelegate
extension MemoFormViewController: UINavigationControllerDelegate {
    
}

//MARK: - UITextViewDelegate
extension MemoFormViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 12) ? 12 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        self.navigationItem.title = subject
    }
}
