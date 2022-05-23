//
//  SceneDelegate.swift
//  AlternateIcon
//
//  Created by Joshua Asbury on 21/9/20.
//

import AlternateIconKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = UINavigationController(rootViewController: AppIconViewController())
        controller.navigationBar.prefersLargeTitles = true
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
