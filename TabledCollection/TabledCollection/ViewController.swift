//
//  ViewController.swift
//  TabledCollection
//
//  Created by Joshua Asbury on 5/9/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    let model = generateRandomData()
    var offsetsCache = [Int: CGFloat]()

    override func loadView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "collectionCell")
        view = tableView
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .systemYellow
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle row selection
        print(#function)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        // if the user had scrolled the collection view, scroll to that position
        cell.collectionViewOffset = offsetsCache[indexPath.row] ?? 0
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        // persist the scroll offset so when we re-create this later we can keep the user scrolled where they were
        offsetsCache[indexPath.row] = cell.collectionViewOffset
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model[collectionView.tag].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = model[collectionView.tag][indexPath.item]
        cell.label.text = "\(indexPath.section),\(indexPath.item)"
        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // handle collection view selection, use `collectionView.tag` if there are many collection views
    }
}

// MARK: - Data helpers

private func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 40
    let numberOfItemsPerRow = 15

    return (0 ..< numberOfRows).map { _ in
        (0 ..< numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

private extension UIColor {
    class func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
