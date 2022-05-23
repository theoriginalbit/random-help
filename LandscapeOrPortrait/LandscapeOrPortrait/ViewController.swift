//
//  ViewController.swift
//  LandscapeOrPortrait
//
//  Created by Joshua Asbury on 6/4/2022.
//

import UIKit

class ViewController: UIViewController {
    let label = UILabel()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Rotating the iPad between Portrait and Landscape doesn't call this method, as nothing changes
        print("Idiom: \(newCollection.userInterfaceIdiom)")
        print("Size class: V\(newCollection.verticalSizeClass) H\(newCollection.horizontalSizeClass)")
        print("Orientation: \(UIDevice.current.orientation)")

//        switch (newCollection.userInterfaceIdiom, newCollection.verticalSizeClass, newCollection.horizontalSizeClass) {
//        case (.pad, _, _)
//        }
    }
}
