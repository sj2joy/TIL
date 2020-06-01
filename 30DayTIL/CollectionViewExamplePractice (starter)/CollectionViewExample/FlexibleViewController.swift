

import UIKit

final class FlexibleViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    var parkImages = ParkManager.imageNames(of: .nationalPark)
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    // MARK: Setup CollectionView
    
    func setupCollectionView() {
        setupFlowLayout()
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setupFlowLayout() {
        //세로방향 스크롤 기준
        let itemsInLine: CGFloat = 4//하나의 라인에 몇개의 아이템을 넣을것인지
        let spacing: CGFloat = 10 //기본값이 10이라 생략가능 (아이템사이의 넓이)
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cvWidth = collectionView.bounds.width
        let contentSize = cvWidth - insets.left - insets.right - (spacing * (itemsInLine - 1))
        let itemSize = (contentSize / itemsInLine).rounded(.down)//소수점 버리는것
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
    }
}


// MARK: - UICollectionViewDataSource

extension FlexibleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCell.identifier, for: indexPath
            ) as! CustomCell
        cell.backgroundColor = .black
        let item = indexPath.item % parkImages.count
        cell.configure(image: UIImage(named: parkImages[item]),
                       title: parkImages[item])
        return cell
    }
}



