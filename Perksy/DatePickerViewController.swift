import UIKit

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

private let years: [Year] = (1900...2018).map(String.init).reversed()

class DatePickerViewController: UIViewController {

    private var month: Month?
    private var day: Day?
    private var year: Year?

    let labelView = UILabel(frame: .zero)

    lazy var monthPickerViewController = MonthPickerViewController(
        months: months,
        configureCell: self.configureMonthCell,
        didTapMonth: self.didTapMonth
    )

    lazy var dayPickerViewController = DayPickerViewController(
        days: days,
        configureCell: self.configureDayCell,
        didTapDay: self.didTapDay
    )

    lazy var yearPickerViewController = YearPickerViewController(
        years: years,
        configureCell: configureYearCell,
        didTapMonth: didTapYear
    )

    init() {
        super.init(nibName: nil, bundle: nil)
        self.addChildViewController(monthPickerViewController)
        self.view.addSubview(monthPickerViewController.view)
        self.view.constrainEdges(to: monthPickerViewController.view)

        let labelView = UILabel(frame: .zero)

        
    }

    func configureMonthCell(_ monthCell: MonthCell, month: Month) {
        monthCell.month = month
    }

    func didTapMonth(month: Month) {
        print("month \(month) was tapped")
        self.month = month
        monthPickerViewController.removeFromParentViewController()
        self.addChildViewController(dayPickerViewController)
        self.view.addSubview(dayPickerViewController.view)
        self.view.constrainEdges(to: dayPickerViewController.view)
    }

    func configureDayCell(_ dayCell: ItemCell, day: Day) {
        dayCell.item = day
    }

    func didTapDay(day: Day) {
        print("day \(day) was tapped")
        self.day = day
        dayPickerViewController.removeFromParentViewController()
        self.addChildViewController(yearPickerViewController)
        self.view.addSubview(yearPickerViewController.view)
        self.view.constrainEdges(to: yearPickerViewController.view)
    }

    func configureYearCell(_ yearCell: ItemCell, year: Year) {
        yearCell.item = year
    }

    func didTapYear(year: Year) {
        self.year = year
        print("the date is \(self.month!) \(self.day!), \(self.year!)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

