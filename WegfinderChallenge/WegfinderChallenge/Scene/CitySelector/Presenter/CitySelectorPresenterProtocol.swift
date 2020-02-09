//
//  CitySelectorPresenterProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CitySelectorPresenterProtocol: BasePresenterProtocol {

    var view: CitySelectorViewProtocol? { get }
    var interactor: CitySelectorInteractorProtocol { get }
    var router: CitySelectorRouterProtocol { get }

    func navigateToDetails(on city: Settlement)

}
