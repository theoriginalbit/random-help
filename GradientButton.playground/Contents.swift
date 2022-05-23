import PlaygroundSupport
import UIKit

class GradientButton: UIButton {
    override var bounds: CGRect {
        didSet {
            gradientLayer.frame = bounds
        }
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

class TestView: UIViewController {
    lazy var button: GradientButton = {
        let button = GradientButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me", for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

PlaygroundPage.current.liveView = TestView()
