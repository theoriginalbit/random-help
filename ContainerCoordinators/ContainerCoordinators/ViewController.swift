import UIKit

class ViewController: UIViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Support", style: .plain, target: self, action: #selector(supportBarButtonItemTapped(_:)))
    }

    @objc private func supportBarButtonItemTapped(_ sender: UIBarButtonItem) {
        navigateToSupportController()
    }
}
