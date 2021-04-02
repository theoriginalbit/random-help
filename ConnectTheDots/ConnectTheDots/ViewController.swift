import UIKit

class ViewController: UIViewController {
    let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple, .cyan, .orange]

    override func viewDidLoad() {
        super.viewDidLoad()

        let canvas = DotsContainerCanvas()
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.backgroundColor = .secondarySystemBackground
        canvas.layer.cornerRadius = 20
        canvas.clipsToBounds = true
        view.addSubview(canvas)

        let rowStack = UIStackView()
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        rowStack.axis = .vertical
        rowStack.distribution = .fillEqually
        rowStack.alignment = .fill
        rowStack.spacing = 20
        canvas.addSubview(rowStack)

        for _ in 0 ..< 6 {
            let colStack = UIStackView()
            colStack.axis = .horizontal
            colStack.distribution = .fillEqually
            colStack.alignment = .fill
            colStack.spacing = 20
            rowStack.addArrangedSubview(colStack)

            for _ in 0 ..< 6 {
                let dot = CircularView()
                dot.translatesAutoresizingMaskIntoConstraints = false
                dot.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
                dot.heightAnchor.constraint(equalTo: dot.widthAnchor).isActive = true
                dot.backgroundColor = colors.randomElement()!
                colStack.addArrangedSubview(dot)
            }
        }

        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            rowStack.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 12),
            rowStack.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -12),
            rowStack.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 12),
            rowStack.bottomAnchor.constraint(equalTo: canvas.bottomAnchor, constant: -12),
        ])
    }
}
