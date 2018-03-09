import UIKit

typealias Item = String

final class DateComponentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let items: [Item]
    let configuration: Configuration
    let configureCell: (ItemCell, Item) -> ()
    let didTapItem: (Item) -> ()

    init(items: [Item],
         configuration: Configuration,
         configureCell: @escaping (ItemCell, Item) -> (),
         didTapItem: @escaping (Item) -> ())
    {
        self.items = items
        self.configuration = configuration
        self.configureCell = configureCell
        self.didTapItem = didTapItem
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {

        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = configuration.layoutMinimumLineSpacing
        layout.minimumInteritemSpacing = configuration.layoutMinimumInteritemSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = configuration.contentInset

        self.view = collectionView
    }

    override func viewDidLoad() {
        if let collection = view as? UICollectionView {
            collection.register(ItemCell.self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didTapItem(item)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCell.self, for: indexPath)
        let item = items[indexPath.row]
        configureCell(cell, item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: configuration.itemWidth(for: collectionView.bounds.width),
            height: configuration.itemHeight
        )
    }

}

extension DateComponentViewController {

    struct Configuration {
        let layoutMinimumLineSpacing: CGFloat
        let layoutMinimumInteritemSpacing: CGFloat
        let contentInset: UIEdgeInsets
        let columnCount: Int
        let itemHeight: CGFloat

        func itemWidth(for viewWidth: CGFloat) -> CGFloat {
            let horizontalInset = contentInset.left + contentInset.right
            let interitemSpacing = CGFloat(columnCount - 1) * layoutMinimumInteritemSpacing + CGFloat(columnCount + 3)
            return (viewWidth - horizontalInset - interitemSpacing) / CGFloat(columnCount)
        }
    }

}
