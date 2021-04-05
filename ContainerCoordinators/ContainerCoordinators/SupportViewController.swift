import UIKit

class SupportViewController: UIViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        title = "Support"
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Contact us", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc func buttonPressed(_ sender: UIButton) {
        navigateToContactUsController()
    }
}
