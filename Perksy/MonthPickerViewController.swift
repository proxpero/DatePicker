import UIKit

typealias Month = String

final class MonthPickerViewController: UIViewController {

    let months: [Month]
    let configureCell: (MonthCell, Month) -> ()
    let didTapMonth: (Month) -> ()

    init(months: [Month], configureCell: @ escaping (MonthCell, Month) -> (), didTapMonth: @escaping (Month) -> ()) {
        self.months =  months
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
            collection.register(MonthCell.self)
        }
    }
}

extension MonthPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = months[indexPath.row]
        didTapMonth(month)
    }

}

extension MonthPickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MonthCell.self, for: indexPath)
        let month = months[indexPath.row]
        configureCell(cell, month)
        return cell
    }


}

extension MonthPickerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 20
        let height = width * 0.7
        return CGSize(width: width, height: height)
    }


}

final class MonthCell: UICollectionViewCell {

    var month: Month = "Month" {
        didSet {
            DispatchQueue.main.async {
                self.monthLabel.text = self.month
            }
        }
    }
    private let monthLabel: UILabel

    override init(frame: CGRect) {

        self.monthLabel = UILabel(frame: .zero)
        super.init(frame: frame)

        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.layer.cornerRadius = 5
        monthLabel.layer.borderColor = UIColor(white: 0.60, alpha: 1.0).cgColor
        monthLabel.layer.borderWidth = 1
        monthLabel.clipsToBounds = true
        monthLabel.textAlignment = .center
        monthLabel.backgroundColor = .blue
        monthLabel.textColor = .white

        contentView.addSubview(monthLabel)
        contentView.constrainEdges(to: monthLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
