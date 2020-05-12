

import UIKit

protocol TextFieldType1Delegate: class {
  func buttonDidTap(text: String?)
}

class TextFieldType1: UIView {
  
  weak var delegate: TextFieldType1Delegate?
  
  private let titleLabel = UILabel()
  private let textField = UITextField()
  private let guideLine = UIView()
  private let enterButton = UIButton()
  
  init(frame: CGRect, title: String, buttonTitle: String) {
    super.init(frame: frame)
    
    titleLabel.text = title
    enterButton.setTitle(buttonTitle, for: .normal)
    
    baseUI()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func baseUI() {
    titleLabel.backgroundColor = .yellow
    titleLabel.numberOfLines = 0
    titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    self.addSubview(titleLabel)
    
    textField.backgroundColor = .gray
    textField.resignFirstResponder()
    self.addSubview(textField)
    
    guideLine.backgroundColor = .black
    self.addSubview(guideLine)
    
    enterButton.setTitleColor(.white, for: .normal)
    enterButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    enterButton.layer.cornerRadius = 16
    enterButton.addTarget(self, action: #selector(enterButtonAction), for: .touchUpInside)
    self.addSubview(enterButton)
  }
  
  private func autoLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.top).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.xSpace).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Standard.ySpace).isActive = true
    textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.xSpace).isActive = true
    textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    guideLine.translatesAutoresizingMaskIntoConstraints = false
    guideLine.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
    guideLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    guideLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    guideLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    
    enterButton.translatesAutoresizingMaskIntoConstraints = false
    enterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    enterButton.topAnchor.constraint(equalTo: guideLine.bottomAnchor, constant: Standard.ySpace).isActive = true
    enterButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    enterButton.widthAnchor.constraint(equalToConstant: Standard.buttonWidth).isActive = true
    enterButton.heightAnchor.constraint(equalToConstant: Standard.buttonHeight).isActive = true
  }
  
  @objc private func enterButtonAction() {
    delegate?.buttonDidTap(text: textField.text)
  }
  
  private struct Standard {
    static let top: CGFloat = 80
    static let xSpace: CGFloat = 32
    static let ySpace: CGFloat = 24
    static let buttonWidth: CGFloat = 200
    static let buttonHeight: CGFloat = 40
  }
}
