import UIKit

final class RootViewController: UIViewController {

    var coordinators: [AnyObject] = []
    let birthdayLabel = UILabel()

    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.text = "When is your birthday?\n(tap anywhere to answer)"
        birthdayLabel.lineBreakMode = .byWordWrapping
        birthdayLabel.numberOfLines = 0
        birthdayLabel.textAlignment = .center
        view.addSubview(birthdayLabel)
        birthdayLabel.center()
        birthdayLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentDatePickerViewController))
        view.addGestureRecognizer(tap)
    }

    @objc func presentDatePickerViewController() {

        let configuration = DatePickerCoordinator.Configuration(
            minYear: 1900,
            maxYear: 2018,
            itemColor: UIColor.blue,
            itemFont: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize),
            itemTextColor: UIColor.white,
            tabButtonColor: UIColor.darkGray,
            tabButtonTextColor: UIColor.white,
            tabButtonSelectedColor: UIColor.lightGray,
            tabButtonSelectedTextColor: UIColor.darkGray
        )

        let datePickerCoordinator = DatePickerCoordinator(presentingViewController: self, configuration: configuration, didCreateDate: datePickerDidCreateDate)
        coordinators.append(datePickerCoordinator)
        
    }

    func datePickerDidCreateDate(_ date: Date) {
        self.dismiss(animated: true) {
            self.birthdayLabel.text = "Your birthday is \(date).\n(tap again to enter a different date)"
        }
    }
}

