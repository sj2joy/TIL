
import UIKit

final class SectionViewController: UIViewController {
    
    // CollectionView 설정
    
    let states = ParkManager.imageNames(of: .state)
    let parkList = ParkManager.list
    lazy var collectionView = UICollectionView(frame: view.frame,
                                               collectionViewLayout: layout)
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20, left: 20, bottom : 20, right: 20)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 150, height: 150)
        
        //헤더, 푸터
        layout.headerReferenceSize = CGSize(width: 60, height: 60)//기본값은 (0,0) 스크롤 뷰가 가로방향일 땐 width값, 세로방향일땐 height값이 필요함
        layout.headerReferenceSize = CGSize(width: 60, height: 60)
        layout.sectionHeadersPinToVisibleBounds = true //기본값 false , header고정시키는 역할

        layout.footerReferenceSize = CGSize(width: 50, height: 50)
//        layout.sectionFootersPinToVisibleBounds = true //스크롤 올렷을때 올라간부분이 바로사라지지않고 남아있는 
        
        return layout
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        //Header,Foot는 register할 때 다른 메서드 사용함***
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.register(SectionFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: SectionFooterView.identifier)
        
        collectionView.register(SectionCell.self,
                                forCellWithReuseIdentifier: SectionCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDataSource

extension SectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {//주의 이름과 공원의 위치가 같으면 카운트시킴
        let parks = parkList.filter({$0.location.rawValue == states[section]})
        return parks.count * 2 //*2는 단순히 숫자 늘리려고(너무적으므로)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.identifier, for: indexPath
            ) as! SectionCell
        //여기선 section이 바로 주어지는게 아닌 indexPath로 주어지므로 indexPath.section처럼 꺼내야함
        let parks = parkList.filter({$0.location.rawValue == states[indexPath.section]})
        let parkName = parks[indexPath.item % parks.count].name //공원 이름만 꺼내오는
        cell.configure(image: UIImage(
            named: parkName),
            title: parkName)
        return cell
    }
    
    //Header,Footer관련
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath) as! SectionHeaderView
            let state = states[indexPath.section]
            header.configure(image: UIImage(named: state), title: state)
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionFooterView.identifier,
                for: indexPath) as! SectionFooterView
            let count = parkList.filter { $0.location.rawValue == states[indexPath.section]}.count * 2 // *2는 위에서 아이템 갯수 * 2해줬기 때문에 여기서도 해줘야 정확하게 나옴
            let title = "총 \(count)개 이미지"
            footer.configure(title: title)
            return footer
        }
    }
}

