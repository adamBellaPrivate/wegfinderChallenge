//
//  CityWeatherForecastViewModel.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

typealias OrderedContent = (orderedKeys: [Date], forecasts: [Date: [Forecast]])

struct CityWeatherForecastViewModel {

    let city: City
    let orderedForecasts: OrderedContent

}
