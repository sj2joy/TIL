

import UIKit

class MyTableViewCell: UITableViewCell {
  
  // 코드로 생성 시
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    print("\n---------- [ init(style:reuserIdentifier) ] ----------")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    print("\n---------- [ prepareForReuse ] ----------")
  }
  
  deinit {
    print("Deinit")
  }
}
