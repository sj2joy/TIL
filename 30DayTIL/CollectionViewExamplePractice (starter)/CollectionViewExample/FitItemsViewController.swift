

import UIKit

class FitItemsViewController: UIViewController {
    
    private enum UI { //enum으로 쓰면 고정값타입으로 활용, struct로 쓰면 .init을 통해 변경가능
        static let itemsInLine: CGFloat = 2
        static let linesOnScreen: CGFloat = 2
        static let itemSpacing: CGFloat = 10.0
        static let lineSpacing: CGFloat = 10.0
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    var parkImages = ParkManager.imageNames(of: .nationalPark)
    
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItem()
        //        setupFlowLayout()
        // view.safeAreaInset은 viewDidLoad에서 안잡힘 ( 0,0,0,0 으로 잡힘)
    }
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        //setupFlowLayout()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFlowLayout()
    }
    // MARK: Setup CollectionView
    
    func setupCollectionView() {
        collectionView.register(
            CustomCell.self,
            forCellWithReuseIdentifier: CustomCell.identifier)//등록개념
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func setupFlowLayout() {
        layout.minimumInteritemSpacing = UI.itemSpacing//가로세로 길이가 다르므로 44,45줄처럼씀
        layout.minimumLineSpacing = UI.lineSpacing
        layout.sectionInset = UI.edgeInsets
        
        FitItemsAndLinesOnScreen()
    }
    
    func FitItemsAndLinesOnScreen() {
        let itemSpacing = UI.itemSpacing * (UI.itemsInLine - 1)
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        let verticalInset = UI.edgeInsets.top + UI.edgeInsets.bottom + view.safeAreaInsets.top
            + view.safeAreaInsets.bottom// (노치가 있는기가와 없는기기에 따라서 정해야되지만 노치가없어도 더해도 상관없음)
        
        //가로세로 변경시 아이템 사이간 간격설정
        let isVertical = layout.scrollDirection == .vertical
        let horizontalSpacing = (isVertical ? itemSpacing : lineSpacing) + horizontalInset
        let verticalSpacing = (isVertical ? lineSpacing : itemSpacing) + verticalInset
        
        let contentWidth = collectionView.frame.width - horizontalSpacing
        let contentHeight = collectionView.frame.height - verticalSpacing
        let width = contentWidth / (isVertical ? UI.itemsInLine : UI.linesOnScreen)
        let height = contentHeight / (isVertical ? UI.linesOnScreen : UI.itemsInLine)
        
        layout.itemSize = CGSize(width: width.rounded(.down), height: height.rounded(.down))    }
    
    // MARK: Setup NavigationItem
    
    func setupNavigationItem() {
        let changeDirection = UIBarButtonItem(
            barButtonSystemItem: .reply,
            target: self,
            action: #selector(changeCollectionViewDirection(_:))
        )
        navigationItem.rightBarButtonItems = [changeDirection]
    }
    
    // MARK: - Action
    
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let direction = layout.scrollDirection
        layout.scrollDirection = direction == .horizontal ? .vertical : .horizontal
        setupFlowLayout()
    }
}


// MARK: - UICollectionViewDataSource

extension FitItemsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCell.identifier,
            for: indexPath
            ) as! CustomCell
        let item = indexPath.item % parkImages.count
        cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
        cell.backgroundColor = .black
        return cell
    }
}



