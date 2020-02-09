//
//  ApiRequestProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/8/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

protocol ApiRequestProtocol {

    var urlPath: String { get }
    var method: HttpMethod { get }
    var isAuthRequired: Bool { get }
    var urlParams: [URLQueryItem] { get }

}
