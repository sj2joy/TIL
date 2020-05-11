

import UIKit

final class TableViewBasic: UIViewController {
    
    override var description: String { "TableView - Basic" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: view.frame, style: .plain)//style생략하면 기본값이 plain
        tableView.dataSource = self  //델리게이트 처럼 self 꼭해줘야함
        view.addSubview(tableView)
        
        //UITableView.self에서 self를 붙이는 이유는 타입자체를 전달할 때 저렇게 씀
        //만약 UITableview()이렇게 가면 행 하나만 전달하게 되는것
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        //tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "CellID")
    }
}

extension TableViewBasic: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1) 매번 새로운 셀 생성 ( 0~49까지 매번 다름)
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        //        cell.textLabel?.text = "\(indexPath.row)"
        //        return cell
        
        //2) 재사용이 가능하게 하는방법 - 미등록 (필요할떄마다 만들어 서 사용) //반환타입 옵셔널
//        let cell: UITableViewCell
//        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "CellID"){
//            cell = reusableCell
//            print("재사용")
//        }else {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
//            print("새로생성")
//        }
//        cell.textLabel?.text = "\(indexPath.row)"
//        return cell
        
        //3) 재사용 - 선등록(필요할때 꺼내서사용, 주로 스토리보드에서 사요) 반환타입 non optional -> 입력 identifier값이 없으면 앱 죽음
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}

