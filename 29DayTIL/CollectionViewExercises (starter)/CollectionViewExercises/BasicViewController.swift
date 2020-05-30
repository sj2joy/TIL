
import UIKit

final class BasicViewController: UIViewController {
    
    let dataSource = cards
    let layout = UICollectionViewFlowLayout()
    //lazy를 쓰는건 아직 뷰 프레임이 잡혀잇지않기때문에
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        //셀간격 줄간격 4씩
        setupCollectionView()
    }
    func setupCollectionView() {
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        //layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        //layout.itemSize = CGSize(width: collectionView.bounds.width - (4 * 3 + 8 + 8) / 4, height: 160)
        layout.itemSize = CGSize(width: 80, height: 160)
        
        
        //collectionView = UICollectionView(frame: view.frame.offsetBy(dx: 0, dy: 0), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource

extension BasicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        //컬렉션 뷰는 item을 씀 row도 사용 가능하긴함
//        cell.contentView.backgroundColor = dataSource[indexPath.item].color // 만약 위에 다른 뷰가 있을 경우엔 이렇게 씀
        cell.backgroundColor = colors.randomElement()
        return cell
        
    }
}
