//
//  ViewController.swift
//  SafeAreaLayoutGuides
//
//  Created by Joshua Asbury on 31/8/20.
//

import UIKit

class ViewController: UIViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemPurple

        let topBar = UIView()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.backgroundColor = .systemRed
        view.addSubview(topBar)

        let topBarContent = UIView()
        topBarContent.translatesAutoresizingMaskIntoConstraints = false
        topBarContent.backgroundColor = .systemGreen
        topBar.addSubview(topBarContent)

        let bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .systemYellow
        view.addSubview(bottomBar)

        let bottomBarContent = UIView()
        bottomBarContent.translatesAutoresizingMaskIntoConstraints = false
        bottomBarContent.backgroundColor = .systemIndigo
        bottomBar.addSubview(bottomBarContent)

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemTeal
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = getLoremIpsum()
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            label.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),

            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            topBarContent.heightAnchor.constraint(equalToConstant: 44),
            topBarContent.topAnchor.constraint(equalTo: topBar.safeAreaLayoutGuide.topAnchor),
            topBarContent.leadingAnchor.constraint(equalTo: topBar.leadingAnchor),
            topBarContent.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -20),
            topBarContent.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),

            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            bottomBarContent.heightAnchor.constraint(equalToConstant: 44),
            bottomBarContent.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            bottomBarContent.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            bottomBarContent.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -20),
            bottomBarContent.bottomAnchor.constraint(equalTo: bottomBar.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func getLoremIpsum() -> String {
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam at mauris mattis, suscipit metus ut, vulputate metus. Curabitur quis lorem sed tellus pulvinar eleifend. Etiam in laoreet justo. Sed sodales, velit non blandit scelerisque, lorem dui cursus quam, in lacinia sem purus a nulla. Proin semper a augue sed interdum. Etiam rutrum eget nibh nec facilisis. Mauris volutpat magna et enim eleifend tempor. Sed sed tortor vulputate arcu fermentum sollicitudin ut in nunc. Praesent venenatis molestie risus vel ornare. Praesent tempus nisi a posuere mattis. Morbi pretium eget nisl id tristique. Morbi molestie facilisis eleifend. Vestibulum ut leo erat. Vivamus a pretium dui. Aenean leo augue, vestibulum quis quam consectetur, porttitor consequat nibh.

        Pellentesque et molestie enim. In sagittis metus id massa scelerisque, sit amet interdum eros pulvinar. Aenean viverra augue vel feugiat ultrices. Maecenas molestie tempus lorem. Vestibulum cursus porttitor turpis, vel gravida mauris vehicula a. Sed vulputate mauris ut lacus porta vulputate. Morbi finibus ante in arcu porta, sed porta tortor egestas. Aenean quis ante in justo pretium tristique. Ut vehicula diam in est porta posuere. Vestibulum fermentum elit sit amet tortor porttitor rhoncus. Morbi id volutpat sapien, ac iaculis tellus. Fusce sit amet nulla ut dolor viverra malesuada vel at ipsum.

        Vestibulum interdum pellentesque nisl, sed gravida mauris tristique vel. Nullam ac dolor in turpis tempus pellentesque sit amet at neque. Sed sit amet sagittis massa, commodo vulputate velit. Vestibulum efficitur magna sed nulla pulvinar mattis. Curabitur finibus, mauris a faucibus faucibus, tellus purus convallis sem, in ultricies elit risus at nibh. Morbi vel porta tortor. Sed volutpat, metus ultrices elementum efficitur, elit velit luctus eros, ac finibus ligula massa vitae purus. In ornare rutrum risus vitae consequat. Vestibulum at leo egestas, vulputate eros et, pulvinar nulla. Etiam ornare ante sem, sed malesuada quam fringilla non. Nullam lectus nisi, rutrum ut purus ut, commodo congue neque. Morbi at ornare augue, a volutpat ante.

        Aenean tincidunt nisl sed arcu pulvinar venenatis. Nulla eu libero cursus, blandit lectus a, vulputate urna. Donec lectus diam, tempus vitae diam ut, dictum suscipit est. Maecenas accumsan, ligula et tristique molestie, erat tellus tempor odio, quis faucibus ex mi eu elit. Nam vitae posuere lectus, in congue sapien. Mauris egestas odio ac nisl eleifend, non varius mi tincidunt. Vestibulum at tellus aliquet, sollicitudin nunc quis, pretium magna.

        Maecenas non nulla commodo, bibendum ligula id, ultrices tellus. Nunc finibus odio pretium, facilisis leo non, fermentum lectus. Cras bibendum turpis ac auctor venenatis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc vitae magna vulputate, lacinia lacus ut, ultricies tortor. Ut nec velit lobortis, ultricies lacus venenatis, rhoncus ipsum. Vivamus fringilla tincidunt justo vel tristique. Nunc mollis sodales orci sit amet maximus. Nullam finibus, leo sed accumsan ornare, justo dui viverra felis, vitae interdum leo augue vitae leo. Suspendisse potenti. Nam placerat metus sed urna pellentesque varius. Sed volutpat enim felis, eget varius nisl convallis quis.
        """
    }
}
