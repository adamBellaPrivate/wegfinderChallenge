//
//  CityWeatherForecastInteractor.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

class CityWeatherForecastInteractor {

    // MARK: - Public properties

    weak var output: CityWeatherForecastInteractorOutput?

    // MARK: - Private properties

    private let networkWorker: NetworkWorkerProtocol

    // MARK: - Lifecycle functions

    init(networkWorker: NetworkWorkerProtocol) {
        self.networkWorker = networkWorker
    }

}

// MARK: - Public class's functions

extension CityWeatherForecastInteractor: CityWeatherForecastInteractorProtocol {

    final func fetchWeatherForecast(by city: Settlement) {
        networkWorker.fetchWeatherForecast(by: city.identifier, onComplition: { [weak self] result in
            switch result {
            case .success(let response):
                self?.output?.onDidLoadWeatherForecastSuccess(with: response)
            case .failure(let error):
                self?.output?.onDidLoadWeatherForecastFailure(with: error)
            }
        })
    }

}
