//
//  CityWeatherForecastInteractorOutput.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CityWeatherForecastInteractorOutput: class {

    func onDidLoadWeatherForecastSuccess(with response: CityWeatherForecastApiResponse)
    func onDidLoadWeatherForecastFailure(with error: Error)

}
