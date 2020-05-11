

import UIKit

class CustomCell: UITableViewCell {
  
  let myLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // 커스텀 뷰를 올릴 때는 contentView 위에 추가
    contentView.addSubview(myLabel)
    myLabel.textColor = .black
    myLabel.backgroundColor = .yellow
  }
  
  required init?(coder aDecoder: NSCoder) {//init에서는 프레임설정을 해도 정확한 높이 너비가 안잡힘 레이아웃에서 잡는게 좋음
    //하지만 고정값으로 입력하면 사용가능
//      myLabel.frame = CGRect(x: 100 y: 15, width: 100, height: 40) 이런식으로
    fatalError("init(coder:) has not been implemented")
  }
  //오토레이아웃 설정 관련
//    override func updateConstraints() {
//        super.updateConstraints()
//    }
    
    
  // 레이아웃 조정 시
  override func layoutSubviews() {
    super.layoutSubviews() // 뷰에서 실제로 layout뷰들을 설정하는것 -- layoutSubviews
    myLabel.frame = CGRect(x: self.frame.width - 120, y: 15, width: 100, height: frame.height - 30)//self는 customcell

  }
}
