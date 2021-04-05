import UIKit

class AppNavigationController: UINavigationController {
    init() {
        super.init(rootViewController: ViewController())
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func navigateToContactUsController(from viewController: UIViewController) {
        let controller = ContactUsViewController()
        viewController.present(controller, animated: true)
    }

    override func navigateToMailController(from viewController: UIViewController, mailToURL email: String) {
        let alertController = UIAlertController(
            title: "Uh Oh!",
            message: "It looks like we weren‘t able to launch your mail client, you‘ll have to open it yourself and email \(email).",
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Got it 👍", style: .default))
        viewController.present(alertController, animated: true)
    }

    override func navigateToSupportController(from viewController: UIViewController) {
        pushViewController(SupportViewController(), animated: true)
    }
}
