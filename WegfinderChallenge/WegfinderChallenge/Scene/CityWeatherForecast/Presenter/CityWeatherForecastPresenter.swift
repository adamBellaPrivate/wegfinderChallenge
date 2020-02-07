//
//  CityWeatherForecastPresenter.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

class CityWeatherForecastPresenter {

    weak var view: CityWeatherForecastViewProtocol?
    let interactor: CityWeatherForecastInteractorProtocol

    private let errorWorker: ErrorWorkerProtocol

    // MARK: - Lifecycle functions

    init(view: CityWeatherForecastViewProtocol,
         interactor: CityWeatherForecastInteractorProtocol,
         errorWorker: ErrorWorkerProtocol) {
        self.view = view
        self.interactor = interactor
        self.errorWorker = errorWorker
    }

}

// MARK: - Public class's functions

extension CityWeatherForecastPresenter: CityWeatherForecastPresenterProtocol {

    final func viewDidLoad() {}

}

// MARK: - Interactor response's functions

extension CityWeatherForecastPresenter: CityWeatherForecastInteractorOutput {

    final func onDidLoadWeatherForecastFailure(with error: Error) {
        let errorMessage = errorWorker.perform(error: error)
        Thread.executeOnMain { [weak self] in
            self?.view?.onShowFailureAlert(with: errorMessage)
        }
    }

}

// MARK: - Private class's functions

private extension CityWeatherForecastPresenter {}
