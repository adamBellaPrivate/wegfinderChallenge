//
//  CityWeatherForecastViewController.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class CityWeatherForecastViewController: BaseViewController {

    // MARK: - Public properties

    var presenter: CityWeatherForecastPresenterProtocol?

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

        view.backgroundColor = AppStyle.Color.sceneBackground
    }

    override final func subscribeToObservers() {
        super.subscribeToObservers()
    }

}

// MARK: - UI's protocol functions

extension CityWeatherForecastViewController: CityWeatherForecastViewProtocol {

    var presentable: UIViewController {
        return self
    }

    final func onShowSceneViewModel() {
        #warning("TODO")
    }

    final func onShowFailureAlert(with message: String) {
        simpleAlert(message: message)
    }

}
