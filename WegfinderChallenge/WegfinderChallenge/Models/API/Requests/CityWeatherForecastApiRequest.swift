//
//  CityWeatherForecastApiRequest.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

struct CityWeatherForecastApiRequest: ApiRequestProtocol {

    let urlPath: String = "forecast"
    let method: HttpMethod = .get
    let isAuthRequired = true
    let urlParams: [URLQueryItem]

    public init(cityId: String, units: TemperatureUnits = .metric) {
        urlParams = [URLQueryItem(name: "id", value: cityId),
                     URLQueryItem(name: "units", value: units.rawValue)]
    }

}
