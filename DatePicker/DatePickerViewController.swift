import UIKit

typealias Month = String
typealias Day = String
typealias Year = String

final class DatePickerViewController: UIViewController {

    init(
        dateComponentLabelViewController: DateComponentLabelViewController,
        dateComponentsPageViewController: DateComponentsPageViewController)
    {
        super.init(nibName: nil, bundle: nil)
        self.addChildViewController(dateComponentLabelViewController)
        self.addChildViewController(dateComponentsPageViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        self.view = view

        let stackView = UIStackView(arrangedSubviews: childViewControllers.map { $0.view })

        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        view.addSubview(stackView)
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -100).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100).isActive = true
        view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
    }


}

