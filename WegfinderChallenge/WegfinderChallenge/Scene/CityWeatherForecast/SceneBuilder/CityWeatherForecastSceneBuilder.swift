//
//  CityWeatherForecastSceneBuilder.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct CityWeatherForecastSceneBuilder {

    func buildScene(with city: Settlement) -> CityWeatherForecastViewProtocol {
        let networkWorker = NetworkWorker()
        let view = CityWeatherForecastViewController()
        var interactor: CityWeatherForecastInteractorProtocol = CityWeatherForecastInteractor(networkWorker: networkWorker)
        let presenter = CityWeatherForecastPresenter(view: view,
                                              interactor: interactor,
                                              errorWorker: ErrorWorker(),
                                              initialCity: city)

        view.presenter = presenter
        interactor.output = presenter

        return view
    }

}
