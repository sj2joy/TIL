

import UIKit

final class CreateNewWSViewController: UIViewController {
    
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create New WorkSpace", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.addTarget(self, action: #selector(didTabCreateWSButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createButton)
        
//        createButton.translatesAutoresizingMaskIntoConstraints = false
//        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        createButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //extension을 사용하면 위에처럼 쓸 필요없이 아래처럼 쓰면 됨
        createButton.layout.centerX().centerY()
        
//        createButton.layout
//            .centerX(equalTo: view.leadingAnchor,constant: 30) // x축이므로 leading,trailing써야함
//            .centerY(constant: 30) // 이런식으로 움직일 수 있음
    }
    
    @objc private func didTabCreateWSButton(_ sender: UIButton) {
        let vc = NameWSViewController()
        let naviController = UINavigationController(rootViewController: vc)
        naviController.modalPresentationStyle = .fullScreen
        present(naviController, animated: true, completion: nil)
    }
    
}

