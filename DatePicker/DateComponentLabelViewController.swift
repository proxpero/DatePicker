import UIKit

final class DateComponentLabelViewController: UIViewController {

    //MARK: Public

    var tabButtonColor = UIColor.darkGray
    var tabButtonTextColor = UIColor.white
    var tabButtonSelectedColor = UIColor.lightGray
    var tabButtonSelectedTextColor = UIColor.darkGray

    var didTapMonthButton: () -> () = {}
    var didTapDayButton: () -> () = {}
    var didTapYearButton: () -> () = {}

    func setMonth(_ value: String) {
        monthButton.setTitle(value, for: .normal)
    }

    func setDay(_ value: String) {
        dayButton.setTitle(value, for: .normal)
    }

    func setYear( value: String) {
        yearButton.setTitle(value, for: .normal)
    }

    func selectComponent(at index: Int) {
        highlightButton(at: index)
    }

    //MARK: Private

    private func configureButtons() {
        for button in [monthButton, dayButton, yearButton] {
            button.backgroundColor = tabButtonColor
            button.setTitleColor(tabButtonTextColor, for: .normal)
        }
    }

    private func highlightButton(at index: Int) {
        configureButtons()
        let selection = [monthButton, dayButton, yearButton][index]
        selection.backgroundColor = tabButtonSelectedColor
        selection.setTitleColor(tabButtonSelectedTextColor, for: .normal)
    }

    private lazy var monthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Month", for: .normal)
        button.addTarget(self, action: #selector(monthButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var dayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Day", for: .normal)
        button.addTarget(self, action: #selector(dayButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var yearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("Year", for: .normal)
        button.addTarget(self, action: #selector(yearButtonAction), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        let stackView = UIStackView(arrangedSubviews: [monthButton, dayButton, yearButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        view = stackView
        configureButtons()
    }

    @objc private func monthButtonAction(sender: UIButton) {
        highlightButton(at: 0)
        didTapMonthButton()
    }

    @objc private func dayButtonAction(sender: UIButton) {
        highlightButton(at: 1)
        didTapDayButton()
    }

    @objc private func yearButtonAction(sender: UIButton) {
        highlightButton(at: 2)
        didTapYearButton()
    }

}
