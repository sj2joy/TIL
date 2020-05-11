

import UIKit

final class TableViewLifeCycle: UIViewController {
  
  override var description: String { "TableView - LifeCycle" }
  
  let data = Array(1...40)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    tableView.delegate = self
   // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "CellId") //MyTableViewCell의 내용을 쓰기 위해서
    //register를 이걸로 바꿈 
    view.addSubview(tableView)
  }
}

// MARK: - UITableViewDataSource

extension TableViewLifeCycle: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel!.text = "Cell \(data[indexPath.row])"
    print("cellForRowAt : \(data[indexPath.row])")
    return cell
  }
}
extension TableViewLifeCycle: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will Display Cell: \(indexPath.row)")
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt  indexPath: IndexPath) {
        print("Did End Displaying Cell : \(data[indexPath.row])")
    }
}
