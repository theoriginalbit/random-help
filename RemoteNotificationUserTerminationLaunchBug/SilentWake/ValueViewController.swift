import UIKit

class ValueViewController: UIViewController {
    let value: Int
    
    init(value: Int) {
        self.value = value
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .yellow
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(value)"
        label.textColor = .black
        view.addSubview(label)
        
        let button = UIButton(type: .custom)
        button.setTitle("Clear", for: [])
        button.setTitleColor(.blue, for: [])
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
    }
}

@objc private extension ValueViewController {
    func clearTapped() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.silentValueKey)
        dismiss(animated: true)
    }
}

private extension OSLog {
    static let file = OSLog(subsystem: "com.example.SilentWake", category: #fileID)
}
