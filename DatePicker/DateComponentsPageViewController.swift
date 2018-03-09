import UIKit

final class DateComponentsPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    var dateComponents: [UIView] = [] {
        didSet {
            if let collectionView = view as? UICollectionView {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
    }

    var didScrollToPageAtIndex: (Int) -> () = { _ in }

    func selectPage(at index: Int) {
        if let collectionView = view as? UICollectionView {
            collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .left, animated: true)
        }
    }

    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        self.view = collectionView
    }

    override func viewDidLoad() {
        if let collectionView = view as? UICollectionView {
            collectionView.register(PageCell.self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateComponents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PageCell.self, for: indexPath)
        cell.setView(dateComponents[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // FIXME: Don't trust floating point numbers to be exactly equal.
        switch scrollView.contentOffset.x {
        case 0.0: didScrollToPageAtIndex(0)
        case scrollView.bounds.width: didScrollToPageAtIndex(1)
        case (scrollView.bounds.width * 2): didScrollToPageAtIndex(2)
        default: break
        }
    }

}

class PageCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(_ subview: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        subview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subview)
        contentView.constrainEdges(to: subview)
    }


}
