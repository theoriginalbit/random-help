//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class DialogDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        let animationDuration = transitionDuration(using: transitionContext)

        fromVC.view.alpha = 1.0

        UIView.animate(withDuration: animationDuration, animations: {
            fromVC.view.alpha = 0.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

class DialogPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)

        toVC.view.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)

        containerView.addSubview(toVC.view)

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            toVC.view.transform = .identity
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}

class DialogPresentationController: UIPresentationController {
    private lazy var dimmingView: UIView! = {
        guard let containerView = containerView else { fatalError("Attempted to instantiate dimmingView without containerView") }
        return configure(UIView(frame: containerView.bounds)) {
            $0.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
            $0.alpha = 0.0
        }
    }()

    private let dismissOnTapOutside: Bool

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, dismissOnTapOutside: Bool) {
        self.dismissOnTapOutside = dismissOnTapOutside
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let safeFrame = containerView?.safeAreaLayoutGuide.layoutFrame,
              let presentedView = presentedView
        else { return .zero }
        // as the presented view how big it wants to be
        let preferredSize = presentedView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)

        return CGRect(x: 0,
                      y: safeFrame.height - preferredSize.height,
                      width: min(safeFrame.width, preferredSize.width),
                      height: min(safeFrame.height, preferredSize.height))
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 5.0
    }

    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)

        if dismissOnTapOutside {
            dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView(_:))))
        }

        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 0.0
        })
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }

    @objc private func didTapDimmingView(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }
}

// MARK: Code this point onward is just code to provide it works an dnot part of the impl. Impl done in 120 including whitespace

func configure<T>(
    _ value: T,
    using block: (inout T) throws -> Void
) rethrows -> T {
    var value = value
    try block(&value)
    return value
}

class DialogViewController: UIViewController {
    private let titleLabel: UILabel
    private let subtitleLabel: UILabel
    private let cancelButton: UIButton
    private let okButton: UIButton
    private let backgroundColor: UIColor

    init() {
        titleLabel = configure(UILabel()) {
            $0.text = "Hold on, we are checking the availability for you…"
            $0.font = .preferredFont(forTextStyle: .title1)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }

        subtitleLabel = configure(UILabel()) {
            $0.text = #"This might take 10-15 seconds, you can wait or press "OK" to continue. We'll notify you once this booking is completed!"#
            $0.font = .preferredFont(forTextStyle: .subheadline)
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }

        cancelButton = configure(UIButton(type: .custom)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("Cancel", for: .normal)
        }

        okButton = configure(UIButton(type: .custom)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("Ok", for: .normal)
        }

        backgroundColor = .white

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = backgroundColor

        let contentView = configure(UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.alignment = .fill
            $0.distribution = .fill
            $0.axis = .vertical
            $0.spacing = 8.0
        }

        view.addSubview(contentView)

        view.addSubview(cancelButton)
        view.addSubview(okButton)

        let inset: CGFloat = 50
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
            contentView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -inset),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),

            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            okButton.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: cancelButton.trailingAnchor, multiplier: 1.0),
            okButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset),
            okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
            okButton.topAnchor.constraint(equalTo: cancelButton.topAnchor, constant: inset),
        ])

        self.view = view
    }
}

extension DialogViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        DialogPresentationController(presentedViewController: presented, presenting: presenting, dismissOnTapOutside: true)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DialogPresentationAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DialogDismissalAnimator()
    }
}

class MyViewController: UIViewController {
    var button: UIButton!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        button = configure(UIButton()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("Hello World!", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        self.view = view
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let controller = DialogViewController()
        present(controller, animated: true)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
