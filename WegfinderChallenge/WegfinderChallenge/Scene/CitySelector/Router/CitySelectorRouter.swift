//
//  CitySelectorRouter.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

class CitySelectorRouter {

    weak var view: CitySelectorViewProtocol?

    // MARK: - Lifecycle functions

    init(view: CitySelectorViewProtocol) {
        self.view = view
    }

}

// MARK: - Public class's functions

extension CitySelectorRouter: CitySelectorRouterProtocol {

    final func navigateToDetails(on city: Settlement) {
        let targetVC = CityWeatherForecastSceneBuilder().buildScene(with: city).presentable
        view?.presentable.navigationController?.pushViewController(targetVC, animated: true)
    }

}
