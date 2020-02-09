//
//  Settlement.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct Settlement: Codable {

    let name: String
    let identifier: String

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }

}
