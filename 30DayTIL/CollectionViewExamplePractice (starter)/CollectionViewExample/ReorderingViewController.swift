

import UIKit

final class ReorderingViewController: UIViewController {
    
    var parkImages = ParkManager.imageNames(of: .nationalPark)
    
    let layout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        cv.backgroundColor = .white
        cv.dataSource = self
        view.addSubview(cv)
        return cv
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout()
        setupLongPressGestureRecognizer()
    }
    
    
    // MARK: Setup FlowLayout
    
    func setupFlowLayout() {
        let itemsInLine: CGFloat = 4
        let spacing: CGFloat = 10
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cvWidth = collectionView.bounds.width
        let contentSize = cvWidth - insets.left - insets.right - (spacing * (itemsInLine - 1))
        let itemSize = (contentSize / itemsInLine).rounded(.down)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
    }
    
    // MARK: Setup Gesture
    
    func setupLongPressGestureRecognizer() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(reorderCollectionViewItem(_:)))
        gesture.minimumPressDuration = 0.5
        collectionView.addGestureRecognizer(gesture)
    }
    
    
    // MARK: - Action
    
    @objc private func reorderCollectionViewItem(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: collectionView)
        switch sender.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location) else { break }
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(location)
        case .cancelled:
            collectionView.cancelInteractiveMovement()
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ReorderingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCell.identifier, for: indexPath
            ) as! CustomCell
        let item = indexPath.item % parkImages.count
        cell.configure(image: UIImage(named: parkImages[item]), title: parkImages[item])
        cell.backgroundColor = .black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard sourceIndexPath != destinationIndexPath else { return }
        let source = sourceIndexPath.item % parkImages.count
        let destination = destinationIndexPath.item % parkImages.count
        print("source:", source, "dest:", destination)
        
        let element = parkImages.remove(at: source)
        parkImages.insert(element, at: destination)//제거햇다가 내가 의도한 목적지로 옮기는
    }
}


