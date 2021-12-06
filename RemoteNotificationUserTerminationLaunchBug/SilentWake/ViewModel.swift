//
//  ViewModel.swift
//  SilentWake
//
//  Created by Joshua Asbury on 6/12/21.
//

import Foundation

class ViewModel {
    var silentValue: Observable<Int>

    init() {
        silentValue = Observable()

        NotificationCenter.default.addObserver(self, selector: #selector(valueChanged), name: UserDefaults.didChangeNotification, object: nil)
        updateValueObservable()
    }

    @objc func valueChanged() {
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
        updateValueObservable()
    }

    func updateValueObservable() {
        guard UserDefaults.standard.object(forKey: UserDefaults.silentValueKey) != nil else { return }
        os_log(.info, log: .file, "%{public}@ %{public}@", #fileID, #function)
        let value = UserDefaults.standard.integer(forKey: UserDefaults.silentValueKey)
        silentValue.accept(value)
    }
}
