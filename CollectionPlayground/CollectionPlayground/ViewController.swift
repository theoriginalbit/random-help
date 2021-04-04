import os.log
import UIKit

class ViewController: UIViewController {
    private static let standardSpacing: CGFloat = 16

    typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>

    struct Item: Hashable {
        let identifier = UUID()
        let value: Int
        let showsButton: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    // MARK: - Internal

    private var dataSource: DataSource!
    private var items = [Item]()

    private var collectionView: UICollectionView {
        view as! UICollectionView
    }

    // MARK: - Overrides

    override func loadView() {
        view = configure(UICollectionView(frame: .zero, collectionViewLayout: makeLayout())) {
            $0.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            $0.backgroundColor = .systemBackground
            $0.alwaysBounceVertical = true
            $0.registerCell(BasicValueCell.self)
            $0.contentInset = .init(top: Self.standardSpacing,
                                    left: 0,
                                    bottom: Self.standardSpacing,
                                    right: 0)
        }

        configureNavItem()
        configureDataSource()
        updateUI(animated: false)
    }

    // MARK: Configuration

    func configureNavItem() {
        navigationItem.title = NSLocalizedString("Items", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addOrganisationPressed(_:)))
    }

    func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(BasicValueCell.self, for: indexPath) else {
                return nil
            }
            cell.bind(to: item)
            return cell
        }
    }

    func makeLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(158)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                         heightDimension: .estimated(158)),
                                                       subitems: [item])
        group.interItemSpacing = .fixed(Self.standardSpacing)

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Self.standardSpacing
        section.contentInsetsReference = .readableContent
        section.contentInsets = .init(top: Self.standardSpacing,
                                      leading: 0,
                                      bottom: Self.standardSpacing,
                                      trailing: 0)

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }

    func updateUI(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()

        snapshot.appendSections([0])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: Actions

    @objc func addOrganisationPressed(_ sender: UIBarButtonItem) {
        items.append(Item(value: Int.random(in: 1 ..< 6), showsButton: Bool.random()))
        updateUI()
    }
}
