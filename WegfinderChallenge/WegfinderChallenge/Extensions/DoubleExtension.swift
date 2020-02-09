//
//  DoubleExtension.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/9/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

extension Double {

    func toTemperature(with unit: TemperatureUnits = .metric) -> String {
        return String(format: "%.0f%@", self.rounded(), unit.denoted())
    }

}
