import UIKit

typealias Year = String

final class YearPickerViewController: UIViewController {

    let years: [Year]
    let configureCell: (ItemCell, Year) -> ()
    let didTapMonth: (Year) -> ()

    init(years: [Year], configureCell: @ escaping (ItemCell, Year) -> (), didTapMonth: @escaping (Year) -> ()) {
        self.years =  years
        self.configureCell = configureCell
        self.didTapMonth = didTapMonth
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {

        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        collectionView.contentInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)

        self.view = collectionView
    }

    override func viewDidLoad() {
        if let collection = view as? UICollectionView {
            collection.register(ItemCell.self)
        }
    }
}

extension YearPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let year = years[indexPath.row]
        didTapMonth(year)
    }

}

extension YearPickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCell.self, for: indexPath)
        let year = years[indexPath.row]
        configureCell(cell, year)
        return cell
    }


}

extension YearPickerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 5) - 20
        let height = width * 0.7
        return CGSize(width: width, height: height)
    }


}
