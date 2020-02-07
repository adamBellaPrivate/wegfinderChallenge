//
//  BaseViewController.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        performViews()
        performStyles()
        subscribeToObservers()
    }

    func performViews() {}
    func performStyles() {}
    func subscribeToObservers() {}

}
