import UIKit

class FixedAlwaysStandardAppearanceTableViewController: UITableViewController {
    var contentOffsetObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        contentOffsetObservation = tableView.observe(\.contentOffset, options: [.initial, .new]) { [weak self] tableView, _ in
            self?.updateNavigationBarAppearanceBasedOn(tableView)
        }
    }

    func updateNavigationBarAppearanceBasedOn(_ scrollView: UIScrollView) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]

        if scrollView.contentOffset.y <= -scrollView.safeAreaInsets.top {
            appearance.shadowColor = .clear
            appearance.titleTextAttributes[.foregroundColor] = UIColor.systemRed
        }

        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5.5)
        navigationItem.standardAppearance = appearance
    }
}
