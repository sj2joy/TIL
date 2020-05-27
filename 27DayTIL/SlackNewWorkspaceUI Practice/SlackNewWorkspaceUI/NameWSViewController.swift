
import AudioToolbox.AudioServices
import UIKit

final class NameWSViewController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.init(red: 18/255, green: 90/255, blue: 153/255, alpha: 1.0), for: .selected)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
        return button
    }()
    private let closeButton: UIButton = {
        let button = UIButton()
        let closeImage = UIImage(systemName: "xmark")
        button.setImage(closeImage, for: .normal)
        button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
        //setPreferredSymbolConfiguration = button image 크기 키울때 사용
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    private let WSTextField: UITextField = {
        let textField = UITextField()
        //NSAttributedString = 글자의 크기나 정렬, 폰트 등 다양한 옵션을 사용할 수 있게 해줌 , 기본값 = plain
        let attrString = NSAttributedString(
            string: "Name your workspace",
            attributes: [.foregroundColor: UIColor.darkText.withAlphaComponent(0.5)] //placeholder색깔 연하게 만드는
            //                .kern: 10 // 자간
            //                NSAttributedString.Key. 여기서 이것저것 설정할 수 있음 ( 알아두면 유용)
        )
        textField.attributedPlaceholder = attrString
        textField.font = UIFont.systemFont(ofSize: 23, weight: .thin)
        textField.borderStyle = .none
        textField.returnKeyType = .go
        textField.autocorrectionType = .no // 자동수정 기능
        textField.autocapitalizationType = .none //맨 첫 글자를 대문자로 할 것인지
        textField.enablesReturnKeyAutomatically = true //아무 키나 입력했을 때 go 키가 활성화됨 (true일 때)
        return textField
    }()
    private let floatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Name your workspace"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.alpha = 0
        //label.isHidden = true //isHidden이랑 alpha 차이는 애니메이션 효과적용 가능여부
        //isHidden은 bool값이라 적용 x , alpha는 값에 변화를 줄 수 있으므로 애니메이션 적용 가능
        return label
    }()
    
    private var floatingCenterYConst: NSLayoutConstraint!
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.hidesWhenStopped = true //indicationView가 stop일 때 숨기는, 기본값 true, false로 하면 계속 남아있음
        return indicatorView
    }()
    
    private var indicatorViewLeadingConst: NSLayoutConstraint! //글자수에 따라서 위치를 바꿔주기 위해 설정해놓은것
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSTextField.becomeFirstResponder()
    }
    
    
    //MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviews([nextButton, closeButton])
        view.addSubviews([WSTextField, floatingLabel, indicatorView])
        
        navigationController?.navigationBar.isHidden = true
        WSTextField.delegate = self
    }
    private func setupConstraint() {
        nextButton.layout
            .top()
            .trailing(constant: -16)
        closeButton.layout
            .top()
            .leading(constant: 16)
            .centerY(equalTo: nextButton.centerYAnchor)
        WSTextField.layout
            .leading(constant: 16)
            .trailing(constant: -16)
            .centerY(constant: -115)
        
        floatingLabel.layout.leading(equalTo: WSTextField.leadingAnchor)
        
        //기본위치
        let defaultCenterYConst = floatingLabel.centerYAnchor.constraint(equalTo: WSTextField.centerYAnchor)
        defaultCenterYConst.priority = UILayoutPriority(500)
        defaultCenterYConst.isActive = true
        
        //텍스트 필드에 입력시 y축으로 30만큼 올리는
        floatingCenterYConst = floatingLabel.centerYAnchor.constraint(equalTo: WSTextField.centerYAnchor, constant: -30)
        floatingCenterYConst.priority = .defaultLow   // 250
        floatingCenterYConst.isActive = true
        
        indicatorView.layout.centerY(equalTo: WSTextField.centerYAnchor)
        indicatorViewLeadingConst = indicatorView.leadingAnchor.constraint(equalTo: WSTextField.leadingAnchor)
        indicatorViewLeadingConst.isActive = true
    }
    
    //MARK: - Action Handler
    //오디오 서비스 쓰려면 import에 먼저 추가해줘야 사용 가능함
    private func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    @objc private func didTapNextButton(_ sender: UIButton) {
        guard nextButton.isSelected, let text = WSTextField.text else { return vibrate() }
        guard !indicatorView.isAnimating else { return }//indicatorView가 돌고 있는지, 애니메이션이 진행중이면 실행되지 않도록
        let textSize = (text as NSString).size(withAttributes: [.font: WSTextField.font!])
        indicatorViewLeadingConst.constant = textSize.width + 8
        indicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.indicatorView.stopAnimating()
            let vc = UrlWSViewController()
            vc.workspaceName = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: - UITextFieldDelegate
extension NameWSViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //return 버튼을 클릭했을 때 실행되는
        didTapNextButton(nextButton)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {//키보드를 누를때마다 or 텍스트가 추가 될 때
        let text = textField.text ?? ""
        //만약 여기서 let replacedText = text + string으로 하면 글자를 삭제할 때 한박자씩 늦게됨(범위단위에서는 안씀) range가 포함된 shouldChangeCharactersIn를 써야함 ****중요
        let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
        //해석하자면 text의 범위안에(범위 = 블록) 있는 모든 문자를 replacedText로 대체한다고 보면됨 ex) a -> aa갈 때 a가 하나 추가되는 것이 아니라 aa자체가 새로 쓰여진다고 보면 됨
        nextButton.isSelected = !replacedText.isEmpty //한글자라도 있으면 next버튼 활성화 상태 유지
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            if replacedText.isEmpty {
                self.floatingCenterYConst.priority = .defaultLow // 내려갈 때(250) ( 중간값 500)
                self.floatingLabel.alpha = 0.0
            } else {
                self.floatingCenterYConst.priority = .defaultHigh // 올라갈 때 (750)
                self.floatingLabel.alpha = 1.0
            }
            self.view.layoutIfNeeded() //위에 if문을 바로 적용시키려고 사용함
        })
        return true
    }
}

