@_exported import OSLog
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
        
        if let userInfo = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
            handleNotification(userInfo)
            return false
        }
        
        if #available(iOS 13.0, *) {
            // Handled by scene delegate
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = ViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        os_log(.info, log: .file, "Remote notification token: %{public}@", token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        os_log(.info, log: .file, "Remote notification error: %{public}@", error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        os_log(.info, log: .file, "Remote notification: %{public}@", userInfo.description)
        handleNotification(userInfo)
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

private extension AppDelegate {
    func handleNotification(_ userInfo: [AnyHashable: Any]) {
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
        guard let value = userInfo["myValue"] as? Int else {
            return UserDefaults.standard.removeObject(forKey: UserDefaults.silentValueKey)
        }
        UserDefaults.standard.set(value, forKey: UserDefaults.silentValueKey)
    }
}

extension UserDefaults {
    static let silentValueKey = "silentValue"
}

private extension OSLog {
    static let file = OSLog(subsystem: "com.example.SilentWake", category: #fileID)
}
