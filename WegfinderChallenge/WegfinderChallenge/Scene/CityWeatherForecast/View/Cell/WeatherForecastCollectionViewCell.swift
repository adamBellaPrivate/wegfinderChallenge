//
//  WeatherForecastCollectionViewCell.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet private weak var lblTime: UILabel!
    @IBOutlet private weak var lblTemperature: UILabel!
    @IBOutlet private weak var imgWeather: UIImageView!

    // MARK: - Private properties

    private let networkWorker: NetworkWorkerProtocol = NetworkWorker()

    // MARK: - Lifecycle functions

    override func awakeFromNib() {
        super.awakeFromNib()

        performStyles()
    }

    final func performContent(with forecast: Forecast) {
        lblTime.text = DateFormatter.timeDateFormat.string(from: forecast.date)
        lblTemperature.text = forecast.main.temp?.toTemperature()

        if let icon = forecast.currentWeatherIcon {
            let urlPath = String(format: networkWorker.iconResourcePath, icon)
            imgWeather.loadImage(with: URL(string: urlPath))
        } else {
            imgWeather.loadImage(with: .none)
        }
    }

}

// MARK: - Private extension

private extension WeatherForecastCollectionViewCell {

    final func performStyles() {
        lblTime.font = AppStyle.Font.regular(of: 14)
        lblTemperature.font = AppStyle.Font.regular(of: 16)
    }

}
