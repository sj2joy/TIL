

import UIKit

final class TableViewCellStyle: UIViewController {
  
  override var description: String { "TableView - CellStyle" }
  
  /***************************************************
   셀 스타일 4가지 (default, subtitle, value1, value2)
   ***************************************************/
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.rowHeight = 70
    tableView.dataSource = self
//    tableView.delegate = self 맨아래 extension쓸때 사용
    view.addSubview(tableView)
    
    //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    
    tableView.rowHeight = UITableView.automaticDimension //(숫자로도 입력해볼것) 셀의높이 일괄지정
//    tableView.rowHeight = 150
//    tableView.estimatedRowHeight = UITableView.automaticDimension //(숫자로도 입력해볼것)
  }
}

// MARK: - UITableViewDataSource

extension TableViewCellStyle: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // 재사용
    let cell: UITableViewCell
    
    if indexPath.row % 4 == 0 {
      // 셀 재사용 시도 후 없으면 생성
      cell = tableView.dequeueReusableCell(withIdentifier: "Default")
        ?? UITableViewCell(style: .default, reuseIdentifier: "Default")
    } else if indexPath.row % 4 == 1 {
      cell = tableView.dequeueReusableCell(withIdentifier: "Subtitle")
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
    } else if indexPath.row % 4 == 2 {
      cell = tableView.dequeueReusableCell(withIdentifier: "Value1")
        ?? UITableViewCell(style: .value1, reuseIdentifier: "Value1")
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "Value2")
        ?? UITableViewCell(style: .value2, reuseIdentifier: "Value2")
    }
    
    // 공통 속성 세팅
    cell.textLabel?.text = "\(indexPath.row * 1000)"
//    cell.detailTextLabel?.text = "ABCD" //detailTextLabel = subTitle밑에 내용입력하고 싶을 때
    cell.imageView?.image = UIImage(named: "bear")
    cell.accessoryType = .detailButton //인포버튼생김
    return cell
  }
}
//extension TableViewCellStyle: UITableViewDelegate { 조건을 가지고셀높이 지정할 때
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row % 4 == 0 {
//            return 120
//        }else {
//            return 50
//        }
//    }
//}
