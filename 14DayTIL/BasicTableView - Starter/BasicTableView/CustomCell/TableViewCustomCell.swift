

import UIKit

final class TableViewCustomCell: UIViewController {
  
  /***************************************************
   커스텀 셀 사용하기
   ***************************************************/
  
  override var description: String { "TableView - CustomCell" }
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 80
    view.addSubview(tableView)
    
    //UITableViewCell(홀수행), CustomCell(짝수행)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
    tableView.register(CustomCell.self, forCellReuseIdentifier: "Custom")
  }
}

// MARK: - UITableViewDataSource

extension TableViewCustomCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : UITableViewCell
    if indexPath.row.isMultiple(of: 2){
        cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath)
        //이렇게 타입캐스팅을 해줘도 위에서 cell을 UITableViewCell로 지정했기 때문에 다시 캐스팅을 해야함
        //이렇게 하면 매번 cell12 = cell 이런식으로 넣어줘야 사용이 가능하기 때문에 번거로움(맨아래처럼 해야 편함)
        (cell as! CustomCell).myLabel.text = "ABCDEFGH" // 타입캐스팅을 통해 mylabel에 접근
//        (cell as! CustomCell).myLabel.frame = CGRect(x: cell.frame.width - 120, y: 15, width: 100, height: cell.frame.height - 30) 여기서하는것 보단 아래 델리게이트에서 하는게나음
    }else {
        cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
    }
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    cell.imageView?.image = UIImage(named: "bear")
    return cell
    
//    if indexPath.row.isMultiple(of: 2) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath)
//        as! CustomCell
//        cell.myLabel.text = "ASDF"
//        return cell
//    }else {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
//        return cell
//    }
//
////    guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath) as? CustomCell else { return UITableViewCell() } // 타입캐스팅을 통해 mylabel에 접근 // 이렇게 해야 매번 cell12 = cell 이런식으로 넣지않고
    //cell1.myLabel  이런식으로 바로 접근해서 사용이 가능하다
//   return cell  // if let이 아닐땐 활성화
  }
}


// MARK: - UITableViewDelegate

extension TableViewCustomCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let customCell = cell as? CustomCell else { return }
        customCell.myLabel.frame = CGRect(x: cell.frame.width - 120, y: 15, width: 100, height: cell.frame.height - 30)
    }
}

//호출 순서는 cellForRowAt -> willdisplaycell -> layoutsubView순서로 호출됨
