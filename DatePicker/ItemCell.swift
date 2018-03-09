import UIKit

final class ItemCell: UICollectionViewCell {

    var item: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.itemLabel.text = self.item
            }
        }
    }
    
    let itemLabel: UILabel

    override init(frame: CGRect) {

        self.itemLabel = UILabel(frame: .zero)
        super.init(frame: frame)

        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.layer.cornerRadius = 5
        itemLabel.layer.borderColor = UIColor(white: 0.60, alpha: 1.0).cgColor
        itemLabel.layer.borderWidth = 1
        itemLabel.clipsToBounds = true
        itemLabel.textAlignment = .center
        contentView.addSubview(itemLabel)
        contentView.constrainEdges(to: itemLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
