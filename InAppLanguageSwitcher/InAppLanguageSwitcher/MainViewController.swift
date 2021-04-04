import UIKit

class MainViewController: UIViewController {
    // Figure out the locales supported by the app automatically, ignoring the "Base" as it's not a valid locale
    private var supportedLocales = Bundle.main.localizations.filter { $0 != "Base" }.map { Locale(identifier: $0) }

    private let welcomeLabel = UILabel()
    private let changeLangaugeButton = UIButton(type: .system)

    override func loadView() {
        // You can ignore the next few lines of code
        view = UIView()
        view.backgroundColor = .systemBackground
        changeLangaugeButton.addTarget(self, action: #selector(showLanguageSwitcher), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [welcomeLabel, changeLangaugeButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)

        // The stack view is pinned to the edges of the screen to demonstrate that RTL languages change the label direction
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        // Ensure everything on screen says what we want in the right language
        updateText()

        // Listen to the localization system for when the locale changes,
        // without this the user can change their locale in app, but won't see a change
        NotificationCenter.default.addObserver(forName: LocalizationSystem.localeDidChange, object: nil, queue: .main) { _ in
            self.updateText()
        }
    }

    func updateText() {
        // We have to be explicit as to which bundle we're loading the strings from. The main bundle is what it defaults
        // to, but in this case we want to load the user's overridden preference, not the one the device has specified
        let buttonTitle = NSLocalizedString("Switch langauge", bundle: .l10nOverride, comment: "")
        changeLangaugeButton.setTitle(buttonTitle, for: .normal)
        welcomeLabel.text = NSLocalizedString("Welcome", bundle: .l10nOverride, comment: "")
    }

    @objc func showLanguageSwitcher() {
        // An action sheet is the simplest UI that I could think of which wouldn't generate a lot of extra noisy code
        // that would detract away from the important code to offer in-app localization
        let alertTitle = NSLocalizedString("Switch langauge", bundle: .l10nOverride, comment: "")
        let controller = UIAlertController(title: alertTitle, message: nil, preferredStyle: .actionSheet)

        // Give the user a button for each of the locales this app supports
        for targetLocale in supportedLocales {
            let localeNameInLocale = targetLocale.localizedString(forIdentifier: targetLocale.identifier)
            controller.addAction(UIAlertAction(title: localeNameInLocale, style: .default, handler: { _ in
                // When the user selects a locale, change to it
                LocalizationSystem.shared.setLocale(targetLocale)
            }))
        }

        // Provide the user the option to cancel, untranslated, because I don't want to go through Google Translate
        // again, it's slow and not translating this doens't really hurt the rest of the example
        controller.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(controller, animated: true)
    }
}
