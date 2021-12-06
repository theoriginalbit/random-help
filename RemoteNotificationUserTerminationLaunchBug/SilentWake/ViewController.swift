import UIKit

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .cyan
    }
    
    override func viewDidLoad() {
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
        
        viewModel.silentValue.subscribe { value in
            DispatchQueue.main.async { [weak self] in
                self?.present(ValueViewController(value: value), animated: true)
            }
        }
    }
}

private extension OSLog {
    static let file = OSLog(subsystem: "com.example.SilentWake", category: #fileID)
}
