import UIKit

extension UIResponder {
    @objc func navigateToMailController(from viewController: UIViewController, mailToURL email: String) {
        guard let next = next else {
            // This gives us a nice piece of diagnostic information in the event
            // this action travels along the chain and isn't handled by anything
            return assertionFailure("⚠️ Unhandled action: \(#function), Last responder: \(self)")
        }

        next.navigateToMailController(from: viewController, mailToURL: email)
    }

    @objc func navigateToContactUsController(from viewController: UIViewController) {
        guard let next = next else {
            // This gives us a nice piece of diagnostic information in the event
            // this action travels along the chain and isn't handled by anything
            return assertionFailure("⚠️ Unhandled action: \(#function), Last responder: \(self)")
        }

        next.navigateToContactUsController(from: viewController)
    }

    @objc func navigateToSupportController(from viewController: UIViewController) {
        guard let next = next else {
            // This gives us a nice piece of diagnostic information in the event
            // this action travels along the chain and isn't handled by anything
            return assertionFailure("⚠️ Unhandled action: \(#function), Last responder: \(self)")
        }

        next.navigateToSupportController(from: viewController)
    }
}

extension UIViewController {
    func navigateToContactUsController() {
        navigateToContactUsController(from: self)
    }

    func navigateToMailController(mailToURL email: String) {
        navigateToMailController(from: self, mailToURL: email)
    }

    func navigateToSupportController() {
        navigateToSupportController(from: self)
    }
}
