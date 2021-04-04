//
//  CollectionViewCell.swift
//  TabledCollection
//
//  Created by Joshua Asbury on 5/9/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let label: UILabel

    override init(frame: CGRect) {
        label = UILabel(frame: frame)
        super.init(frame: frame)
        contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .systemPurple
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
