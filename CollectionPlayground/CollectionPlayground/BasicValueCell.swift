import UIKit

class BasicValueCell: UICollectionViewCell {
    private let image = configure(UIImageView(image: UIImage(systemName: "pencil.circle"))) {
        $0.contentMode = .scaleAspectFit
        $0.setBorder(width: 2.0, color: .red)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private let titleLabel = configure(UILabel()) {
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.textColor = .label
        $0.setBorder(width: 2.0, color: .blue)
    }

    private let subtitleLabel = configure(UILabel()) {
        $0.font = .preferredFont(forTextStyle: .subheadline)
        $0.textColor = .secondaryLabel
        $0.setBorder(width: 2.0, color: .green)
    }

    private let button = configure(UIButton()) {
        $0.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.setBorder(width: 2.0, color: .purple)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        let labelStackView = configure(UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])) {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.distribution = .fill // default value, just being explicit
        }
        let mainStackView = configure(UIStackView(arrangedSubviews: [image, labelStackView, button])) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.axis = .horizontal
            $0.spacing = 16
            $0.alignment = .fill // .fill will make them fill vertical height
        }
        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),

            image.heightAnchor.constraint(equalTo: image.widthAnchor), // you can do constraints like this to enforce the image retain aspect ratio
        ])
    }
}

extension BasicValueCell: CollectionReusableView {
    func bind(to item: ViewController.Item) {
        // Update the text in all the labels
        titleLabel.text = "Item \(item.value) title"
        subtitleLabel.text = "Item \(item.value) subtitle"
        button.isHidden = !item.showsButton
    }
}

private extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
