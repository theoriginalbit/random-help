//
//  ViewController.swift
//  Animation
//
//  Created by Joshua Asbury on 25/8/20.
//

import UIKit

class ViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.addTarget(self, action: #selector(showNextScreen(_:)), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: settingsButton),
        ]
    }

    @objc func showNextScreen(_ sender: UIButton) {
        let controller = UIViewController()
        controller.view.backgroundColor = .red
        controller.presentationController?.delegate = self
        present(controller, animated: true)
    }

    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        transitionCoordinator?.animate(alongsideTransition: { _ in
            // guard context.isInteractive else { return }
            self.settingsButton.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { _ in
            self.settingsButton.transform = .identity
        })
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        transitionCoordinator?.animate(alongsideTransition: { _ in
            // guard context.isInteractive else { return }
            self.settingsButton.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: { _ in
            self.settingsButton.transform = .identity
        })
    }
}
