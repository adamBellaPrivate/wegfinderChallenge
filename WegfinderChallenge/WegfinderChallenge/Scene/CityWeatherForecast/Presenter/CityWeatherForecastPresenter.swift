//
//  CityWeatherForecastPresenter.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

class CityWeatherForecastPresenter {

    // MARK: - Public properties

    weak var view: CityWeatherForecastViewProtocol?
    let interactor: CityWeatherForecastInteractorProtocol

    // MARK: - Private properties

    private let errorWorker: ErrorWorkerProtocol
    private let initialCity: Settlement

    // MARK: - Lifecycle functions

    init(view: CityWeatherForecastViewProtocol,
         interactor: CityWeatherForecastInteractorProtocol,
         errorWorker: ErrorWorkerProtocol,
         initialCity: Settlement) {
        self.view = view
        self.interactor = interactor
        self.errorWorker = errorWorker
        self.initialCity = initialCity
    }

}

// MARK: - Public class's functions

extension CityWeatherForecastPresenter: CityWeatherForecastPresenterProtocol {

    final func viewDidLoad() {
        interactor.fetchWeatherForecast(by: initialCity)
    }

}

// MARK: - Interactor response's functions

extension CityWeatherForecastPresenter: CityWeatherForecastInteractorOutput {

    final func onDidLoadWeatherForecastSuccess(with response: CityWeatherForecastApiResponse) {
        Thread.executeOnBackground { [weak self] in
            let orderedForecasts = self?.orderForecasts(with: response.forecast) ?? ([], [:])
            Thread.executeOnMain { [weak self] in
                self?.view?.onShowSceneViewModel(with: CityWeatherForecastViewModel(city: response.city,
                                                                                    orderedForecasts: orderedForecasts))
            }
        }
    }

    final func onDidLoadWeatherForecastFailure(with error: Error) {
        let errorMessage = errorWorker.perform(error: error)
        Thread.executeOnMain { [weak self] in
            self?.view?.onShowFailureAlert(with: errorMessage)
        }
    }

}

// MARK: - Private class's functions

private extension CityWeatherForecastPresenter {

    final func orderForecasts(with forecasts: [Forecast]) -> OrderedContent {
        let groupedItems = Dictionary(grouping: forecasts.sorted(by: { $0.date < $1.date }), by: { Calendar.current.startOfDay(for: $0.date) })
        let keys = Array(groupedItems.keys.sorted().prefix(4))
        let result = groupedItems.filter({ keys.contains($0.key) })
        return (keys, result)
    }

}
