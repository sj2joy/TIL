

import UIKit

final class TableViewRefresh: UIViewController {
  
  override var description: String { "TableView - Refresh" }
  
  /***************************************************
   테이블뷰를 새로 불러올 때마다 숫자 목록을 반대로 뒤집어서 출력하기
   ***************************************************/
  
  let tableView = UITableView()
    var data = Array(1...40)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(//navigation관련은 나중수업에서
        title : "Refresh", style: .plain , target: self , action: #selector(reloadData)
    )
  }
  
  func setupTableView() {
    tableView.frame = view.frame
    tableView.rowHeight = 60
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
//    tableView.rowHeight = 80 //행의 높이 조절
    
    let refreshControl = UIRefreshControl()
    refreshControl.tintColor = .blue
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    let attStr = NSAttributedString(
        string: "Refreshing..." ,
        attributes: [.font : UIFont.systemFont(ofSize: 30),
            .kern: 5 // 자간
        ]
    )
    refreshControl.attributedTitle = attStr 
    //refreshControl.attributedTitle = NSAttributedString(string: "Refreshing....")
    
    tableView.refreshControl = refreshControl
    }
  
  @objc func reloadData() {
    //data를 클릭할때마다 내림차순 - 오름차순 - 내림차순 순으로
    data.reverse() // reversed 아님 , reversed는 반환값이 있어야함 ex) data = data.reversed()이렇게써야함
    tableView.refreshControl?.endRefreshing() // <- 안쓰면 refresh동작모션이 안없어짐
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource

extension TableViewRefresh: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel?.text = "\(data[indexPath.row])" //1부터 하려면 "(data[indexPath.row])"로 하면됨 이렇게해야 나중에 reverse가 작동
    return cell
  }
}
