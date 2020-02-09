//
//  CityWeatherForecastViewProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CityWeatherForecastViewProtocol: BaseViewControllerProtocol {

    var presenter: CityWeatherForecastPresenterProtocol? { get set }

    func onShowSceneViewModel(with viewModel: CityWeatherForecastViewModel)
    func onShowFailureAlert(with message: String)

}
