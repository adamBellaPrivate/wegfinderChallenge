//
//  CityWeatherForecastApiResponse.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct CityWeatherForecastApiResponse: Codable {
    let city: City
    let forecast: [Forecast]

    private enum CodingKeys: String, CodingKey {
        case city
        case forecast = "list"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(city, forKey: .city)
        try container.encodeIfPresent(forecast, forKey: .forecast)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decode(City.self, forKey: .city)
        forecast = try container.decodeIfPresent([Forecast].self, forKey: .forecast) ?? []
    }
}
