import UIKit

typealias Day = String

final class DayPickerViewController: UIViewController {

    let days: [Day]
    let configureCell: (ItemCell, Day) -> ()
    let didTapDay: (Day) -> ()

    init(days: [Day], configureCell: @ escaping (ItemCell, Day) -> (), didTapDay: @escaping (Day) -> ()) {
        self.days = days
        self.configureCell = configureCell
        self.didTapDay = didTapDay
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

extension DayPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        didTapDay(day)
    }

}

extension DayPickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ItemCell.self, for: indexPath)
        let day = days[indexPath.row]
        configureCell(cell, day)
        return cell
    }


}

extension DayPickerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 7) - 7
        let height = width * 0.7
        return CGSize(width: width, height: height)
    }


}


