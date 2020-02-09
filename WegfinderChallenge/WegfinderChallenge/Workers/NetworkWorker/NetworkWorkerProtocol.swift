//
//  NetworkWorkerProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol NetworkWorkerProtocol {

    typealias NetworkAnswerCallback<T: Decodable> = (Result<T, Error>) -> Void

    var iconResourcePath: String { get }

    func fetchWeatherForecast(by cityId: String,
                              onComplition handler: @escaping NetworkAnswerCallback<CityWeatherForecastApiResponse>)

}
