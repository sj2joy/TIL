
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    //MARK: - AutoLayoutAnchor Helper
    var layout: UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    @discardableResult // result를 사용하지 않아도 warning이 뜨지않도록 하는
    func top(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        //NSLayoutYAxisAnchor에 관한 설정을 아무것도 하지 않으면 실행하지 않는다는 뜻
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.topAnchor // anchor가 nil이 아니면 ??뒤에 실행
        topAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
        
    }
    @discardableResult
    func leading(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {//NSLayoutXAxisAnchor? = nil -- NSLayoutXAxisAnchor에 관한 설정을 하지않으면 실행 하지않음
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.leadingAnchor
        leadingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func bottom(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.bottomAnchor
        bottomAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func trailing(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c:CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.trailingAnchor
        trailingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func centerX(equalTo anchor: NSLayoutXAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerXAnchor
        centerXAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor? = nil, constant c: CGFloat = 0) -> Self {
        let anchor = anchor ?? superview!.safeAreaLayoutGuide.centerYAnchor
        centerYAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
}
