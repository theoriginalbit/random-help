import UIKit

extension NSLayoutConstraint {
    func identifier(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }
}

class ContactUsViewController: UIViewController {
    private static let linkGetHelp = "app://contactus/feedback"

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        title = "Contact us"

        let blurbTextView = UITextView()
        blurbTextView.translatesAutoresizingMaskIntoConstraints = false
        blurbTextView.backgroundColor = nil
        blurbTextView.isScrollEnabled = false
        blurbTextView.isEditable = false
        blurbTextView.attributedText = blurbText
        blurbTextView.delegate = self

        view.addSubview(blurbTextView)

        let emailUsButton = UIButton()
        emailUsButton.translatesAutoresizingMaskIntoConstraints = false
        emailUsButton.setTitle("Email us", for: .normal)
        emailUsButton.addTarget(self, action: #selector(emailUsButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(emailUsButton)

        let edgeInset: CGFloat = 25

        NSLayoutConstraint.activate([
            blurbTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            blurbTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInset),
            blurbTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInset),

            emailUsButton.topAnchor.constraint(equalTo: blurbTextView.bottomAnchor, constant: 30),
            emailUsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInset),
            emailUsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInset),
            emailUsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -edgeInset),
            emailUsButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    private var blurbText: NSAttributedString {
        let title = """
        If you have a question or a bug to report, you can email us using the button below.

        Please note, it may take us 1-2 business days to respond.

        You can also click here for the online support.
        """
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.preferredFont(forTextStyle: .body),
        ]
        let attributedString = NSMutableAttributedString(string: title, attributes: attributes)
        let linkRange = (title as NSString).range(of: "click here")
        attributedString.addAttribute(.link, value: Self.linkGetHelp, range: linkRange)
        return attributedString
    }

    @objc private func emailUsButtonPressed(_ sender: UIButton) {
        navigateToMailController(mailToURL: "bob@example.com")
    }
}

extension ContactUsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if url.absoluteString == Self.linkGetHelp {
            let controller = UINavigationController(rootViewController: SupportViewController())
            show(controller, sender: self)
        }
        return false
    }
}
