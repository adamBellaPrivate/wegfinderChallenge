//
//  CityWeatherForecastSceneBuilder.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct CityWeatherForecastSceneBuilder {

    func buildScene() -> CityWeatherForecastViewProtocol {
        let view = CityWeatherForecastViewController()
        var interactor: CityWeatherForecastInteractorProtocol = CityWeatherForecastInteractor()
        let presenter = CityWeatherForecastPresenter(view: view,
                                              interactor: interactor,
                                              errorWorker: ErrorWorker())

        view.presenter = presenter
        interactor.output = presenter

        return view
    }

}
