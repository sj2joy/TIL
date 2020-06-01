

import UIKit

final class CustomCellViewController: UIViewController {
    
    let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(
        frame: view.frame, collectionViewLayout: flowLayout
    )
    var showImage = false
    let itemCount = 120
    let parksImage = ParkManager.imageNames(of: .nationalPark)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationItem()
    }
    
    // MARK: Setup Views
    
    private func setupCollectionView() {
        setupFlowLayout()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCircle")
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func setupFlowLayout() {
        if showImage {
            flowLayout.itemSize = CGSize(width: 120, height: 120)
            flowLayout.minimumInteritemSpacing = 15
            flowLayout.minimumLineSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            flowLayout.itemSize = CGSize(width: 60, height: 60)
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
    
    private func setupNavigationItem() {
        let changeItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(changeCollectionViewItems(_:))
        )
        let changeDirection = UIBarButtonItem(
            barButtonSystemItem: .reply,
            target: self,
            action: #selector(changeCollectionViewDirection(_:))
        )
        navigationItem.rightBarButtonItems = [changeItem, changeDirection]
    }
    
    // MARK: - Action
    
    @objc private func changeCollectionViewItems(_ sender: Any) {
        showImage.toggle()
        setupFlowLayout()//toggle에 따라 다시 호출해서 실행해야함
        collectionView.reloadData() //안쓰면 첫 호출시에 image가 안뜸(layout만 바뀌고 cell이 안바뀔때)
    }
    
    @objc private func changeCollectionViewDirection(_ sender: Any) {
        let direction = flowLayout.scrollDirection
        flowLayout.scrollDirection = direction == .horizontal ? .vertical : .horizontal
    }
    func color(at indexPath: IndexPath) -> UIColor {
        let max = itemCount
        let currentIndex = CGFloat(indexPath.item)
        
        //최소값 0.1~ 최대값 0.9
        //0.1을 더하는건 최소값 0을 없애기 위해서, 0.8을 곱하는건 1이 넘어갔을 때 다시 내리기위해
        let factor = 0.1 + (currentIndex / CGFloat(max)) * 0.8
        if showImage {//image상태에서 titleLabel글씨 색 선명하게 보고싶을때
            return .init(hue: factor, saturation: 1, brightness: 1, alpha: 1)
        }else {
        //hue 색상 , saturation 채도, brightness 명도
        return .init(hue: factor, saturation: factor, brightness: 1, alpha: 1)
    }
}
}

// MARK: - UICollectionViewDataSource

extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //showImage가 true면 image사용 false면 기본 서클 사용
        let cell: UICollectionViewCell!
        if showImage {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
            let item = indexPath.item % parksImage.count
            cell = customCell
            //커스텀 셀에 넣는 코드
            customCell.configure(image: UIImage(named: parksImage[item]),
                                 title: parksImage[item])
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCircle", for: indexPath)
            cell.layer.cornerRadius = cell.frame.width / 2
        }
        //image상태일때 cornerRadius적용하려면 CustomCell 가서 clipsToBounds = true 써줘야함
        cell.backgroundColor = color(at: indexPath)
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
//cell의 크기를 랜덤하게 하려면 써야함, 위에서 delegate self 해줘야 함***
extension CustomCellViewController: UICollectionViewDelegateFlowLayout {
    //올리거나 내릴때 천천히 커지면서 보이게하는 효과
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = .init(scaleX: 0.3, y: 0.3)
        
        UIView.animate(withDuration: 0.3){
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        if indexPath.item % 5 == 2 {
            return layout.itemSize.applying(.init(scaleX: 2, y: 2))//나머지가 2인 cell만 4배크기가 되도록
        } else {
            return layout.itemSize
        }
        
    }
    //크기에 관한 정보만 쓸 것이므로 아래는 없어도 됨
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return .zero
    //
    //    }
}
