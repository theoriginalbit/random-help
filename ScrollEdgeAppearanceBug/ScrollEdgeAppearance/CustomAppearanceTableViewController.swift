import UIKit

class CustomAppearanceTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        standardAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5.5)
        navigationItem.standardAppearance = standardAppearance

        // When large titles are allowed, you would expect the following appearance to be applied when the large title is showing
        // When large titles are not allowed, you'd expect the following appearance to be applied when scrolled to the top.
        // On the first detail screen (second screen in app) which never allows large titles this scroll edge appearance will never be used. Feedback from TSI, this is a bug.
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithOpaqueBackground()
        scrollEdgeAppearance.shadowColor = .clear
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        scrollEdgeAppearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5.5)
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont.preferredFont(forTextStyle: .largeTitle)]
        navigationItem.scrollEdgeAppearance = scrollEdgeAppearance
    }
}
