//
//  Config.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

typealias SerializableConfig = [String: Config]

struct Config: Decodable {

    let baseUrl: String
    let weatherApiId: String
    let iconResourcePath: String

}
