//: A UIKit based Playground for presenting user interface

import Darwin
import PlaygroundSupport
import UIKit

class FacesColorButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        layer.backgroundColor = backgroundColor.cgColor
    }

    @available(*, unavailable)
    required init? (coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground

        let purpleButton = FacesColorButton(backgroundColor: .systemPurple)
        let redButton = FacesColorButton(backgroundColor: .systemRed)
        let blueButton = FacesColorButton(backgroundColor: .systemBlue)
        let mintButton = FacesColorButton(backgroundColor: .systemMint)
        let greenButton = FacesColorButton(backgroundColor: .systemGreen)
        let orangeButton = FacesColorButton(backgroundColor: .systemOrange)

        let stackView = UIStackView(arrangedSubviews: [purpleButton, redButton, blueButton, mintButton, greenButton, orangeButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10
        view.addSubview(containerView)
        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),

            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])

        for subview in stackView.arrangedSubviews {
            subview.widthAnchor.constraint(equalTo: subview.heightAnchor).isActive = true
        }

        self.view = view
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
