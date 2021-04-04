import UIKit

final class LocalizationSystem {
    static let localeDidChange = NSNotification.Name(rawValue: "LocalizationSystemLocaleDidChange")
    private static let userLocalePreferenceKey = "userL10nOverride"
    
    static let shared = LocalizationSystem()
    
    fileprivate private(set) var locale: Locale
    fileprivate private(set) var bundle: Bundle
    
    init() {
        // Figure out what is the correct locale when the app has just launched
        // User preference is the most important, so if we have a user defaults value, that'll be the one to use
        // Next preference is the first preferred localization listed in the main bundle
        // Last preference is development language, english. but it should never get to this point
        let userPreferredLocale = UserDefaults.standard.string(forKey: Self.userLocalePreferenceKey)
        let bundlePreferredLocale = Bundle.main.preferredLocalizations.first
        let fallbackLocale = "en"
        
        // Initialize the locale from the preferences above
        self.locale = Locale(identifier: userPreferredLocale ?? bundlePreferredLocale ?? fallbackLocale)
        // Figure out the correct bundle containing the resources for this locale
        bundle = Bundle(forLocale: locale) ?? .main
        
        // call through to updateUI otherwise RTL languages won't be RTL at launch
        updateUI()
    }
    
    func setLocale(_ newLocale: Locale) {
        // when the locale is updated, make sure it's actually one we can switch to
        guard Bundle.main.localizations.contains(newLocale.identifier) else { return }
        
        // Update the in-memory locale and bundle with the locale information
        self.locale = newLocale
        self.bundle = Bundle(forLocale: locale) ?? .main
        
        // Persist the change, we want to remember it the next time the app launches
        UserDefaults.standard.set(newLocale.identifier, forKey: Self.userLocalePreferenceKey)
        
        updateUI()
    }
    
    private func updateUI() {
        // Override the UIView appearance proxy with explicitly forced LTR / RTL otherwise the views may not
        // correctly change their content modes (left aligned text would need to be right aligned in an RTL lang)
        let contentAttribute: UISemanticContentAttribute =
            Locale.characterDirection(forLanguage: locale.identifier) == .rightToLeft
            ? .forceRightToLeft
            : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = contentAttribute
        
        // Force the current key window to notice the change in the semantic content attribute.
        // This is done by taking a copy of the root view controller, `nil`ing it out on the window,
        // and then reassigning it to the window.
        // NOTE: This probably work if the app has multiple scenes, the other scenes would have the wrong text direction
        guard
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
            let rootVC = window.rootViewController
        else { return }
        window.rootViewController = nil
        window.rootViewController = rootVC
        
        // Inform the app that translations need to change
        NotificationCenter.default.post(name: Self.localeDidChange, object: nil, userInfo: nil)
    }
}

// MARK: Helpers to make it easier to access throughout the app

extension Bundle {
    static var l10nOverride: Bundle {
        LocalizationSystem.shared.bundle
    }
    
    // A helper for this system to make a Bundle for the locale so as to access the l10n files
    fileprivate convenience init?(forLocale locale: Locale) {
        guard let path = Bundle.main.path(forResource: locale.identifier, ofType: "lproj") else { return nil }
        self.init(path: path)
    }
}
