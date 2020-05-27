import AudioToolbox.AudioServices
import UIKit

final class UrlWSViewController: UIViewController {
  
  private let nextButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.lightGray, for: .normal)
    button.setTitleColor(.init(red: 18/255, green: 90/255, blue: 153/255, alpha: 1.0), for: .selected)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    return button
  }()
  
  private let backButton: UIButton = {
    let button = UIButton(type: .system)
    let boldConfig = UIImage.SymbolConfiguration(weight: .bold)//앞 페이지랑 다른방식으로 이미지지정한거 알아두기
    let image = UIImage(systemName: "arrow.left", withConfiguration: boldConfig)
    button.setImage(image, for: .normal)
    button.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Get a URL (Letters, numbers, and dashes only)"
    label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    return label
  }()
  
  private let urlTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont.systemFont(ofSize: 23, weight: .thin)
    textField.borderStyle = .none
    textField.returnKeyType = .go
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.enablesReturnKeyAutomatically = true
    return textField
  }()
  
  private let placeholderLabel: UILabel = {
    let label = UILabel()
    label.text = ".slack.com"//placeholder가 아니라 비슷한 색깔의 레이블을 만들어서 덮은것
    label.textColor = UIColor.darkText.withAlphaComponent(0.5)
    label.font = UIFont.systemFont(ofSize: 23, weight: .thin)
    return label
  }()
  
  private let errorMessageLabel: UILabel = {
    let label = UILabel()
    label.text = "This URL is not available. Sorry!"
    label.textColor = UIColor.darkText.withAlphaComponent(0.5)
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.isHidden = true
    return label
  }()
  private var placeholderLeadingConst: NSLayoutConstraint!
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "This is the address that you'll use to sign in to Slack."
    label.textColor = UIColor.darkText.withAlphaComponent(0.7)
    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    label.numberOfLines = 2 //2줄로 구성할 때 사용
    return label
  }()
  
  // MARK: Internal Properties
  
  var workspaceName: String = ""
  //앞페이지의 vc.workspaceName을 받아옴
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    urlTextField.becomeFirstResponder()
  }
  
  
  // MARK: - Setup
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubviews([nextButton, backButton])
    view.addSubviews([titleLabel, urlTextField, placeholderLabel, errorMessageLabel])
    view.addSubviews([descriptionLabel])
    
    urlTextField.delegate = self
    urlTextField.text = workspaceName
  }
  
  private func setupConstraints() {
    nextButton.layout.top().trailing(constant: -16)
    backButton.layout.leading(constant: 16).centerY(equalTo: nextButton.centerYAnchor)
    
    urlTextField.layout.leading(constant: 16).centerY(constant: -115)
    titleLabel.layout
      .leading(equalTo: urlTextField.leadingAnchor)
      .centerY(equalTo: urlTextField.centerYAnchor, constant: -26)
    errorMessageLabel.layout
      .leading(equalTo: urlTextField.leadingAnchor)
      .centerY(equalTo: urlTextField.centerYAnchor, constant: +26)
    descriptionLabel.layout
      .top(equalTo: urlTextField.bottomAnchor, constant: 125)
      .leading(equalTo: urlTextField.leadingAnchor)
      .trailing(constant: -16)
    
    // placeholderLabel
    placeholderLabel.layout.centerY(equalTo: urlTextField.centerYAnchor)
    
    let textSize = (workspaceName as NSString).size(withAttributes: [.font: urlTextField.font!])
    placeholderLeadingConst = placeholderLabel.leadingAnchor
      .constraint(equalTo: urlTextField.leadingAnchor, constant: textSize.width)
    placeholderLeadingConst.isActive = true
  }
  
  
  // MARK: - Action Handler
  
  @objc private func didTapBackButton(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapNextButton(_ sender: UIButton) {
    guard nextButton.isSelected, !["error", "fail"].contains(urlTextField.text!) else {
      shakeAnimation()
      errorMessageLabel.isHidden = false
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
      return
    }
    print("didTapNextButton")
  }
  
  private func shakeAnimation() {
    UIView.animateKeyframes(withDuration: 0.25, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
        self.urlTextField.center.x -= 8
        self.placeholderLabel.center.x -= 8
      })
      UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
        self.urlTextField.center.x += 16
        self.placeholderLabel.center.x += 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
        self.urlTextField.center.x -= 16
        self.placeholderLabel.center.x -= 16
      })
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
        self.urlTextField.center.x += 8
        self.placeholderLabel.center.x += 8
      })
    })
  }
  
}


// MARK: - UITextFieldDelegate

extension UrlWSViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    didTapNextButton(nextButton)
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text, let range = Range(range, in: text) else {
        //앞페이지에선 NSString사용 , 여기선 같은 작업을 다른 방법으로 적용.
      return true
    }
    let replacedText = text.replacingCharacters(in: range, with: string)
    nextButton.isSelected = !replacedText.isEmpty
    errorMessageLabel.isHidden = true
    
    guard replacedText.count <= 20 else { return false } //20글자 이상이면 더이상 입력 안되도록
    
    //글자를 입력할 때마다 slack.com 글자가 움직이는
    let textFieldAttr = [NSAttributedString.Key.font: textField.font!]
    let textWidthSize = (replacedText as NSString).size(withAttributes: textFieldAttr).width
    placeholderLeadingConst.constant = textWidthSize
    
    return true
  }
}
