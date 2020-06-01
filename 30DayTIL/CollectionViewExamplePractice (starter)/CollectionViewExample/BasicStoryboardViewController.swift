
import UIKit

final class BasicStoryboardViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.dataSource = self //여기선 스토리보드에서 연결해놨으므로 안써도 되지만 코드로만 할 때는 무조건 써줘야함
        
    }
    let parkImages = ParkManager.imageNames(of: .nationalPark)
}
    

//MARK: - UICollectionViewDataSource

extension BasicStoryboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkImages.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for:  indexPath)
        if let imageView = cell.contentView.subviews.first as? UIImageView {
            imageView.image = UIImage(named: parkImages[indexPath.item % parkImages.count]) // count * 3을 해놨기 때문에 나눠줘야함, 그렇지 않으면 갯수 초과로 오류
            cell.layer.cornerRadius = cell.frame.width / 2
            imageView.contentMode = .scaleAspectFill
        }

        return cell
    }
    
    
}
