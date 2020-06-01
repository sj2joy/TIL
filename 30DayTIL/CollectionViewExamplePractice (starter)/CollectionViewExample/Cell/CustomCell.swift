

import UIKit

final class CustomCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        clipsToBounds = true//image상태일때 cornerRadius적용하려면 이걸 써줘야함
        layer.cornerRadius = 20
        
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        [imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
            
        ])
        //titleLabel을 나타낼 때 쓰지만 imageView가 들어갈 경우 크기에 변동을 줄 수없음
//        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        //이럴때 CustomCell과 SectionCell에
        //titleLabel.heightAnchor.constraint(equalToConstant: 25)를 위에 추가해주는방법이있음
    }
    
    // MARK: Configure Cell
    //imageView, titleLabel에 private걸어 놨기 때문에 별도의 함수지정을 통해서 넣어줘야함
    func configure(image: UIImage?, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
