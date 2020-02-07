//
//  CityWeatherForecastPresenterProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CityWeatherForecastPresenterProtocol: BasePresenterProtocol {

    var view: CityWeatherForecastViewProtocol? { get }
    var interactor: CityWeatherForecastInteractorProtocol { get }

}
