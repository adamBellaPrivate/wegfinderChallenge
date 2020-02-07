//
//  Dynamic.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

class Dynamic<T> {

    typealias Listener = (T) -> Void
    private var listener: Listener?
    private var ignoreListener = false

    var value: T {
        didSet {
            guard !ignoreListener else { return }
            listener?(value)
        }
    }

    init(_ initValue: T) {
        value = initValue
    }

    func changeValueWithoutListener(with value: T) {
        ignoreListener = true
        self.value = value
        ignoreListener = false
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        bind(listener)
        listener?(value)
    }

}
