//
//  CitySelectorInteractorOutput.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CitySelectorInteractorOutput: class {

    func onDidLoadCityListSuccess(with items: [Settlement])
    func onDidLoadCityListFailure(with error: Error)

}
