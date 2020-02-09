//
//  TemperatureUnits.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

enum TemperatureUnits: String {
    case standard
    case metric
    case imperial

    func denoted() -> String {
        switch self {
        case .metric: return "°C"
        case .imperial: return "°F"
        default: return "K"
        }
    }
}
