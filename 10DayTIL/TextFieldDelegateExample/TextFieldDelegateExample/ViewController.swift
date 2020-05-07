//
//  ViewController.swift
//  TextFieldDelegateExample


import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self // 1
        // Do any additional setup after loading the view.
    }


}
extension ViewController : UITextFieldDelegate { //2
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //키보드 내려가게 하는거 (enter 쳤을때 )
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharaterIn range: NSRange,
                   replacementString string : String) -> Bool { //a만 안찍히게
        return string == "a" ? false : true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField.text == "red" {
            myView.backgroundColor = .red
        }else if textField.text == "blue"{
            myView.backgroundColor = .blue
        }else if textField.text == "black"{
            myView.backgroundColor = .black
        }else{
            myView.backgroundColor = .gray
        }
}
}
