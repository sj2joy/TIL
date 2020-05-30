
// 셀 크기 = (80, 80) / 아이템과 라인 간격 = 4 / 인셋 = (25, 5, 25, 5)
// 헤더 높이 50, 푸터 높이 3
import UIKit

final class SupplementaryViewController: UIViewController {
    
    var dataSource: [Section] = sections
    
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    
    let layout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = .init(top: 25, left: 5, bottom: 25, right: 5)
        layout.itemSize = CGSize(width: 80, height: 80)
        
        
        layout.headerReferenceSize = CGSize(width: 0, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        
        layout.footerReferenceSize = CGSize(width: 0, height: 3)
        layout.sectionFootersPinToVisibleBounds = true
        
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell" )
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        
        view.addSubview(collectionView)
    }
}


// MARK: - UICollectionViewDataSource

extension SupplementaryViewController: UICollectionViewDataSource {
    //section개수 , 여기선 0~ 4까지 5개
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    //아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = colors.randomElement()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
            
            header.configure(title: "Section\(indexPath.section)")
            
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            footer.backgroundColor = .black
            return footer
        }
    }
}

