import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jjajangMenuLabel: UILabel!
    @IBOutlet weak var jjamBbongMenuLabel: UILabel!
    @IBOutlet weak var tangSuYukMenuLabel: UILabel!
    
    @IBOutlet weak var jjaJangCostLabel: UILabel!
    @IBOutlet weak var jjamBbongCostLabel: UILabel!
    @IBOutlet weak var tangSuYukCostLabel: UILabel!
    
    @IBOutlet weak var jjajangOrderButton: UIButton!
    @IBOutlet weak var jjamBbongOrderButton: UIButton!
    @IBOutlet weak var tangSuYukOrderButton: UIButton!
    
    @IBOutlet weak var jjaJangCountLabel: UILabel!
    @IBOutlet weak var jjamBbongCountLabel: UILabel!
    @IBOutlet weak var tangSuYukCountLabel: UILabel!
    
    let currentMoneyLabel = UILabel()
    let currentOrderCostLabel = UILabel()
    
    let initOrderButton = UIButton()
    let chargeButton = UIButton()
    
    var orderData = OrderData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabel(text: "소지금", color: .systemGreen, y: 350)
        addCurrentMoneyLabel()
        
        addLabel(text: "결제금액", color: .systemOrange, y: 400)
        addCurrentOrderCostLabel()
        
        addInitOrderButton()
        addChargeButton()
        
        jjaJangCountLabel  .text   = "\(orderData.getJjaJangCount())"
        jjamBbongCountLabel.text   = "\(orderData.getJjamBbongCount())"
        tangSuYukCountLabel.text   = "\(orderData.getTangSuYukCount())"
    }
    
    func addLabel(text: String, color: UIColor, y: CGFloat) {
        let label = UILabel()
        
        label.frame = CGRect(x: 20, y: y, width: 80, height: 40)
        label.backgroundColor = color
        label.text = text
        label.textAlignment = .center
        label.textColor = .label
        
        view.addSubview(label)
    }
    
    func addCurrentMoneyLabel() {
        currentMoneyLabel.frame = CGRect(x: 110, y: 350, width: 140, height: 40)
        currentMoneyLabel.backgroundColor = .systemGreen
        currentMoneyLabel.text = "\(orderData.getCurrentMoney())원"
        currentMoneyLabel.textAlignment = .right
        currentMoneyLabel.textColor = .label
        
        view.addSubview(currentMoneyLabel)
    }
    
    func addCurrentOrderCostLabel() {
        currentOrderCostLabel.frame = CGRect(x: 110, y: 400, width: 140, height: 40)
        currentOrderCostLabel.backgroundColor = .systemOrange
        currentOrderCostLabel.text = "\(orderData.getCurrentOrderCost())원"
        currentOrderCostLabel.textAlignment = .right
        currentOrderCostLabel.textColor = .label
        
        view.addSubview(currentOrderCostLabel)
    }
    
    func addInitOrderButton() {
        initOrderButton.frame = CGRect(x: 270, y: 350, width: 80, height: 40)
        initOrderButton.setTitle("초기화", for: .normal)
        initOrderButton.titleLabel?.textColor = .label
        initOrderButton.backgroundColor = .darkGray
        initOrderButton.addTarget(self, action: #selector(initOrder), for: .touchUpInside)
        
        view.addSubview(initOrderButton)
    }
    
    func addChargeButton() {
        chargeButton.frame = CGRect(x: 270, y: 400, width: 80, height: 40)
        chargeButton.setTitle("결제", for: .normal)
        chargeButton.titleLabel?.textColor = .label
        chargeButton.backgroundColor = .darkGray
        chargeButton.addTarget(self, action: #selector(chargeOrder), for: .touchUpInside)
        
        view.addSubview(chargeButton)
    }
    
    @objc func initOrder() {
        orderData.initOrderData()
        
        initOrderLabel()
    }
    
    func initOrderLabel() {
        currentMoneyLabel    .text = "\(orderData.getCurrentMoney())원"
        currentOrderCostLabel.text = "\(orderData.getCurrentOrderCost())원"
        jjaJangCountLabel    .text = "\(orderData.getJjaJangCount())"
        jjamBbongCountLabel  .text = "\(orderData.getJjamBbongCount())"
        tangSuYukCountLabel  .text = "\(orderData.getTangSuYukCount())"
    }
    
    @objc func chargeOrder() {
        
        let chargeAlert = UIAlertController(
            title: "결제하기",
            message: "총 결제금액은 \(orderData.getCurrentOrderCost())원 입니다.",
            preferredStyle: .alert
        )
        
        chargeAlert.addAction(UIAlertAction(title: "확인", style: .default) {
            UIAlertAction in
            let isAvaiableToPay = (self.orderData.getCurrentMoney() - self.orderData.getCurrentOrderCost()) > 0
            
            if isAvaiableToPay {
                self.orderData.charge()
                
                self.initOrderLabel()
            } else {
                
                let lessMoneyAlert = UIAlertController(
                    title: "소지금 부족",
                    message: "\(-(self.orderData.getCurrentMoney() - self.orderData.getCurrentOrderCost()))원이 부족합니다.",
                    preferredStyle: .alert
                )
                
                lessMoneyAlert.addAction(UIKit.UIAlertAction(title: "확인", style: .default, handler: nil))
                
                self.present(lessMoneyAlert, animated: true, completion: nil)
            }
            
        })
        
        chargeAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(chargeAlert, animated: true, completion: nil)
    }
    
    @IBAction func order(_ sender: UIButton) {
        if sender == jjajangOrderButton {
            orderData.plusJjaJangCount()
            orderData.addCurrentChargeCost(5000)
            
            jjaJangCountLabel.text = "\(orderData.getJjaJangCount())"
        } else if sender == jjamBbongOrderButton {
            orderData.plusJjamBbongCount()
            orderData.addCurrentChargeCost(6000)
            
            jjamBbongCountLabel.text = "\(orderData.getJjamBbongCount())"
        } else if sender == tangSuYukOrderButton {
            orderData.plusTangSuYukCount()
            orderData.addCurrentChargeCost(12000)
            
            tangSuYukCountLabel.text = "\(orderData.getTangSuYukCount())"
        }
        
        currentOrderCostLabel.text = "\(orderData.getCurrentOrderCost())원"
    }
    
}

