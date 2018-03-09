import UIKit

public extension UICollectionViewCell {

    static var cellReuseIdentifier: String {
        return "\(self)"
    }
}

public extension UICollectionView {

    func register<A: UICollectionViewCell>(_ cellType: A.Type) {
        register(A.self, forCellWithReuseIdentifier: A.cellReuseIdentifier)
    }

    func dequeueReusableCell<A: UICollectionViewCell>(_ cellType: A.Type, for indexPath: IndexPath) -> A {
        guard let cell = dequeueReusableCell(withReuseIdentifier: A.cellReuseIdentifier, for: indexPath) as? A else {
            fatalError("Could not create a cell from type \(A.cellReuseIdentifier)")
        }
        return cell
    }

}

public extension UIView {

    func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        constrainEqual(attribute: attribute, to: to, multiplier: multiplier, constant: constant)
    }

    func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, _ toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ])
    }

    func constrainEdges(to view: UIView) {
        constrainEqual(attribute: .top, to: view, .top)
        constrainEqual(attribute: .leading, to: view, .leading)
        constrainEqual(attribute: .trailing, to: view, .trailing)
        constrainEqual(attribute: .bottom, to: view, .bottom)
    }

    func center(in view: UIView? = nil) {
        guard let container = view ?? self.superview else { fatalError() }
        centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 0).isActive = true
    }

}

