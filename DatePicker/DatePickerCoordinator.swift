import UIKit

final class DatePickerCoordinator {

    private let datePickerViewController: DatePickerViewController
    private let dateComponentLabelViewController: DateComponentLabelViewController
    private let dateComponentsPageViewController: DateComponentsPageViewController
    private var dateComponents = DateComponents(calendar: Calendar(identifier: Calendar.Identifier.gregorian))

    private let configuration: Configuration
    private let didCreateDate: (Date) -> ()

    var date: Date? { return dateComponents.date }

    init(presentingViewController: UIViewController, configuration: Configuration, didCreateDate: @escaping (Date) -> ()) {

        self.dateComponentLabelViewController = DateComponentLabelViewController(nibName: nil, bundle: nil)
        self.dateComponentsPageViewController = DateComponentsPageViewController(nibName: nil, bundle: nil)

        self.datePickerViewController = DatePickerViewController(
            dateComponentLabelViewController: dateComponentLabelViewController,
            dateComponentsPageViewController: dateComponentsPageViewController
        )
        self.configuration = configuration
        self.didCreateDate = didCreateDate

        dateComponentLabelViewController.didTapMonthButton = labelDidSelectMonth
        dateComponentLabelViewController.didTapDayButton = labelDidSelectDay
        dateComponentLabelViewController.didTapYearButton = labelDidSelectYear

        dateComponentsPageViewController.dateComponents = [monthPickerViewController, dayPickerViewController, yearPickerViewController].map { $0.view }
        dateComponentsPageViewController.didScrollToPageAtIndex = didScrollToPage

        presentingViewController.present(datePickerViewController, animated: true)
        dateComponentLabelViewController.selectComponent(at: 0)
    }

    func didScrollToPage(at index: Int) {
        dateComponentLabelViewController.selectComponent(at: index)
    }

    func labelDidSelectMonth() {
        dateComponentsPageViewController.selectPage(at: 0)
    }

    func labelDidSelectDay() {
        dateComponentsPageViewController.selectPage(at: 1)
    }

    func labelDidSelectYear() {
        dateComponentsPageViewController.selectPage(at: 2)
    }

    func configureMonthCell(_ cell: ItemCell, month: Month) {
        cell.item = month
        cell.itemLabel.backgroundColor = configuration.itemColor
        cell.itemLabel.textColor = configuration.itemTextColor
        cell.itemLabel.font = configuration.itemFont
    }

    func configureDayCell(_ cell: ItemCell, day: Day) {
        cell.item = day
        cell.itemLabel.backgroundColor = configuration.itemColor
        cell.itemLabel.textColor = configuration.itemTextColor
        cell.itemLabel.font = configuration.itemFont
    }

    func configureYearCell(_ cell: ItemCell, year: Year) {
        cell.item = year
        cell.itemLabel.backgroundColor = configuration.itemColor
        cell.itemLabel.textColor = configuration.itemTextColor
        cell.itemLabel.font = configuration.itemFont
    }

    func didTapMonth(month: Month) {
        dateComponents.month = months.index(of: month)! + 1
        checkComponents()
        dateComponentLabelViewController.selectComponent(at: 1)
        dateComponentLabelViewController.setMonth(month)
        dateComponentsPageViewController.selectPage(at: 1)
    }

    func didTapDay(day: Day) {
        dateComponents.day = Int(day)
        checkComponents()
        dateComponentLabelViewController.selectComponent(at: 2)
        dateComponentLabelViewController.setDay(day)
        dateComponentsPageViewController.selectPage(at: 2)
    }

    func didTapYear(year: Year) {
        dateComponents.year = Int(year)
        checkComponents()
        dateComponentLabelViewController.selectComponent(at: 0)
        dateComponentLabelViewController.setYear(value: year)
        dateComponentsPageViewController.selectPage(at: 0)
    }

    func checkComponents() {
        if let _ = dateComponents.day, let _ = dateComponents.month, let _ = dateComponents.year, let date = dateComponents.date {
            didCreateDate(date)
        }
    }

    private let months: [Month] = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    private let days = (1...31).map(String.init)
    lazy private var years: [Year] = {
        return (configuration.minYear...configuration.maxYear).map(String.init).reversed()
    }()

    lazy var monthPickerViewController = DateComponentViewController(
        items: months,
        configuration: DateComponentViewController.Configuration(
            layoutMinimumLineSpacing: 5,
            layoutMinimumInteritemSpacing: 5,
            contentInset: UIEdgeInsets(
                top: 12,
                left: 12,
                bottom: 12,
                right: 12
            ),
            columnCount: 3,
            itemHeight: 44
        ),
        configureCell: configureMonthCell,
        didTapItem: didTapMonth
    )

    lazy var dayPickerViewController = DateComponentViewController(
        items: days,
        configuration: DateComponentViewController.Configuration(
            layoutMinimumLineSpacing: 5,
            layoutMinimumInteritemSpacing: 5,
            contentInset: UIEdgeInsets(
                top: 12,
                left: 12,
                bottom: 12,
                right: 12
            ),
            columnCount: 7,
            itemHeight: 44
        ),
        configureCell: configureDayCell,
        didTapItem: didTapDay
    )

    lazy var yearPickerViewController = DateComponentViewController(
        items: years,
        configuration: DateComponentViewController.Configuration(
            layoutMinimumLineSpacing: 5,
            layoutMinimumInteritemSpacing: 5,
            contentInset: UIEdgeInsets(
                top: 12,
                left: 12,
                bottom: 12,
                right: 12
            ),
            columnCount: 5,
            itemHeight: 44
        ),
        configureCell: configureYearCell,
        didTapItem: didTapYear
    )

    struct Configuration {
        let minYear: Int
        let maxYear: Int
        let itemColor: UIColor
        let itemFont: UIFont
        let itemTextColor: UIColor
        let tabButtonColor: UIColor
        let tabButtonTextColor: UIColor
        let tabButtonSelectedColor: UIColor
        let tabButtonSelectedTextColor: UIColor
    }
}

