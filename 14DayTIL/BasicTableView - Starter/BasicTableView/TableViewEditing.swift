

import UIKit

final class TableViewEditing: UIViewController {
  
  /***************************************************
   테이블뷰 목록 수정하기 (insert, delete 등)
   ***************************************************/
  
  override var description: String { "TableView - Editing" }
  
  let tableView = UITableView()
  var data = Array(1...50)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Edit", style: .plain, target: self, action: #selector(switchToEditing)
    )
  }
  
  func setupTableView() {
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
    
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
    refreshControl.tintColor = .blue
    refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  @objc func reloadData() {
    tableView.refreshControl?.endRefreshing()
    tableView.reloadData()
  }
  
  @objc func switchToEditing() {//edit버튼을 눌럿을때 동작하게 하는
   //isediting 현재 true면 false로 false면 true로 전달하는것
    tableView.setEditing(!tableView.isEditing, animated: true)//!tableView.isEditing은 editing상태가 true면 false로
    //false면 true로 바꿔줌
  }
}

// MARK: - UITableViewDataSource

extension TableViewEditing: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel?.text = "\(data[indexPath.row])"
    return cell
  }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // commit editingStyle = edit상태가 됐을 때 어떤 작업을 수행하도록 할 때 사용
        switch editingStyle {
        case .none : print("none")
        case .delete :
            data.remove(at: data.firstIndex(of: data[indexPath.row])!)
            tableView.deleteRows(at: [indexPath], with: .automatic)//이렇게만 하면 에러가 뜸 위에도 추가해야함
            //deleteRows는 ui만 지우는거고 data.remove를 해줘야함 * data를 먼저 삭제해줘야함(순서중요)
            print("delete", indexPath)
        case .insert : // 만약 수정이 아닌 삭제로 하려면 위에 delete랑 똑같이 쓰면됨
            data.remove(at: data.firstIndex(of: data[indexPath.row])!)
            tableView.deleteRows(at: [indexPath], with: .right)
            data.insert(data.randomElement()!, at: data.firstIndex(of: data[indexPath.row])!)
            tableView.insertRows(at: [indexPath], with: .automatic)
            print("insert", indexPath)
        default: print("default")
        }
    }

}


// MARK: - UITableViewDelegate

extension TableViewEditing: UITableViewDelegate {
    //기본값은 true, canEditRowAt = 해당되는 애들만 적용되도록
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       indexPath.row.isMultiple(of: 2)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { //datasource에서 commiteditingStyle내용을 적용할 때
        let row = indexPath.row
        if row % 3 == 0 {
            return .none
        }else if row % 3 == 1 {
            return .delete
        }else {
            return .insert
        }
    }
    //ios 8 ~10 까지
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//    }
  //ios 11이상에선 아래
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    print("\n-----------[trailingSwipeActionsConfigurationForRowAt]--------------\n")
        let addAction = UIContextualAction(style: .normal, title: "Add") { ( action, sourceView, actionPerformed) in
            print("Add Action")
            actionPerformed(true)
        }
        addAction.backgroundColor = .blue
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { ( action, sourceView, actionPerformed) in
                 print("delete Action")
                 actionPerformed(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [addAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false //드래그를 끝까지 햇을때 실행할지안할지에 대한/ 기본값true
        return configuration
    }
    
    //trailing ,leading 왼쪽 오른쪽 차이
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add") { ( action, sourceView, actionPerformed) in
            print("Add Action")
            actionPerformed(true)
        }
        addAction.backgroundColor = .blue
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { ( action, sourceView, actionPerformed) in
                 print("delete Action")
                 actionPerformed(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [addAction, deleteAction])
             configuration.performsFirstActionWithFullSwipe = false
             return configuration
    }
}

