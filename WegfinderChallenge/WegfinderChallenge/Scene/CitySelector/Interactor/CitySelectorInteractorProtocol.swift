//
//  CitySelectorInteractorProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CitySelectorInteractorProtocol {

    var output: CitySelectorInteractorOutput? { get set }

    func loadCityList()

}
