

import UIKit

final class BasicCodeViewController: UIViewController {
    
    let itemCount = 100
    var collectionView: UICollectionView!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setupCollectionView()
        setupNavigationItem()
    }
    
    // MARK: Setup Views
    
    func setupSliders() {
        let sizeSlider = UISlider()
        sizeSlider.minimumValue = 10
        sizeSlider.maximumValue = 200
        sizeSlider.value = 50
        
        let spacingSlider = UISlider()
        spacingSlider.minimumValue = 0
        spacingSlider.maximumValue = 50
        spacingSlider.value = 10
        spacingSlider.tag = 1
        
        let edgeSlider = UISlider()
        edgeSlider.minimumValue = 0
        edgeSlider.maximumValue = 50
        edgeSlider.value = 10
        edgeSlider.tag = 2
        
        let sliders = [sizeSlider, spacingSlider, edgeSlider]
        sliders.forEach {
            $0.addTarget(self, action: #selector(editLayout(_:)), for: .valueChanged)
        }
        let stackView = UIStackView(arrangedSubviews: sliders)
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupCollectionView() {
        //collectionView는 frame + collectionViewLayout같이 설정해줘야함 안그럼 컴파일에러(일반적으로 flowLayout이 사용됨)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 //기본값 10
        layout.minimumInteritemSpacing = 10 //기본값 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)//기본값 0
        //    layout.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5) //위와 동일함
        layout.itemSize = CGSize(width: 60, height: 60)//기본값 50, 50
        
        //view의 프레임을 y에서 250만큼 내린값을 가져오는것
        collectionView = UICollectionView(frame: view.frame.offsetBy(dx: 0, dy: 250), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow //지정안하면 기본값 검정
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ColorCircle")
        view.addSubview(collectionView)
    }
    
    func setupNavigationItem() {//스크롤 방향 좌우 전환하는 바버튼 아이템 생성
        let changeDirection = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(changeCollectionViewDirection(_:))
            )
            navigationItem.rightBarButtonItem = changeDirection
    }
    
    
    // MARK: Action
    @objc private func changeCollectionViewDirection(_ sender: Any) {//스크롤방향 좌우전환 메서드
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let direction = layout.scrollDirection
        layout.scrollDirection = (direction == .horizontal) ? .vertical : .horizontal
        //현재 가로면 - 세로 , 세로면 - 가로
      }
    
    @objc private func editLayout(_ sender: UISlider) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let value = CGFloat(sender.value)
        if sender.tag == 0 {
            layout.itemSize = CGSize(width: value, height: value)
        } else if sender.tag == 1 {
            layout.minimumInteritemSpacing = value
            layout.minimumInteritemSpacing = value
        } else {
            let inset = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
            layout.sectionInset = inset
        }
    }

}


// MARK: - UICollectionViewDataSource

extension BasicCodeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCircle", for: indexPath)
        cell.backgroundColor = [.red, .orange, .green, .blue, .black, .cyan, .magenta].randomElement()
        return cell
    }
}
