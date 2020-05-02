
//1. ViewController 데이터 전달
//> AViewController 와 BViewController 를 만든 뒤, 각각 하나씩의 Label 생성
//> A와 B를 화면 전환할 때마다 각 Label에 전환 횟수 1씩 증가
//  e.g. A에서 B로 갈 때 1, B에서 다시 A로 넘어올 때 2, 다시 A에서 B로 가면 3
import UIKit

var number = 0

class ViewController: UIViewController {
    let label = UILabel()
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupButton()
        // Do any additional setup after loading the view.
    }

    func setupLabel(){
        label.frame.size = CGSize(width: view.frame.width, height: 100)
        label.center = view.center
        label.text = ("\(number)")
        label.font = UIFont(name: "Arial", size: 90)
        label.textAlignment = .center
        label.textColor = .red
        view.addSubview(label)
    }
    func setupButton(){
        
        button.frame = CGRect(x: 100, y: 100, width: 300 , height: 300)
        button.titleLabel?.font = UIFont(name: "Arial", size: 100)
        button.setTitle("Click!!", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
    }
    @objc private func didTapButton(_ Sender: UIButton){
        let nextVC = BViewController()
        nextVC.modalPresentationStyle = .fullScreen
        
        number += 1
        present(nextVC, animated: true, completion: nil)
    }
}



