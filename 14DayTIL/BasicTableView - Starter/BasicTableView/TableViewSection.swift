

import UIKit

final class TableViewSection: UIViewController {
  
  override var description: String { "TableView - Section" }
  
  /***************************************************
   섹션을 나누어 데이터 목록 출력하기
   ***************************************************/

  lazy var sectionTitles: [String] = fruitsDict.keys.sorted()
  let fruitsDict = [
    "A": ["Apple", "Avocado"],
    "B": ["Banana", "Blackberry"],
    "C": ["Cherry", "Coconut"],
    "D": ["Durian"],
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
  }
}


// MARK: - UITableViewDataSource

extension TableViewSection: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {//이함수를 넣음으로서 BCD까지 다 나옴
        fruitsDict.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]//이함수 넣음으로서 ABCD 섹션이 나뉨
    }
    //만약 headerSection에 뷰를 넣고 싶으면 위에 extension에 UITableViewDelegate 추가하고
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }이렇게 추가해주면됨
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let titles = fruitsDict.keys.sorted() // ["A" ,"B", "C","D"]
        let key = sectionTitles[section]// titles[0]- A  //titles[1] - B
        return fruitsDict[key]!.count  //fruitsDict["A"] // [Apple, Avocado].count
//        return fruitsDict[sectionTitles[section]]!.count 위에 3줄을 한줄로 줄이면 이렇게 됨
  }
  //indexPath의 값은(0, 0)과 같이 section, row로 이루어져 있으며,
    //section이 바뀔 때마다 row는 0부터 다시시작함
    //A = section , Apple/Avocado = row
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    let fruits = fruitsDict[sectionTitles[indexPath.section]]!//A,B,C,D
    cell.textLabel?.text = "\(fruits[indexPath.row])"//[Apple,Avocado]
    return cell
  }
}
