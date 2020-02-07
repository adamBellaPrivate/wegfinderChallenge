//
//  CitySelectorViewController.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class CitySelectorViewController: BaseViewController {

    var presenter: CitySelectorPresenterProtocol?

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    // MARK: - UI initial functions

    override final func performViews() {
        super.performViews()
    }

    override final func performStyles() {
        super.performStyles()
    }

    override final func subscribeToObservers() {
        super.subscribeToObservers()

    }
}

// MARK: - UI's protocol functions

extension CitySelectorViewController: CitySelectorViewProtocol {

    var presentable: UIViewController {
        return self
    }

    func onShowSceneViewModel() {
        #warning("TODO")
    }

    func onShowFailureAlert(with message: String) {
        simpleAlert(message: message)
    }

}
