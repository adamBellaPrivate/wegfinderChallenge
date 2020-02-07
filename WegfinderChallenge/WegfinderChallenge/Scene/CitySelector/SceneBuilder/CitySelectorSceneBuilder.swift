//
//  CitySelectorSceneBuilder.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct ItemListSceneBuilder {

    func buildScene() -> CitySelectorViewProtocol {
        let view = CitySelectorViewController()
        var interactor: CitySelectorInteractorProtocol = CitySelectorInteractor()
        let presenter = CitySelectorPresenter(view: view, interactor: interactor, router: CitySelectorRouter(view: view))

        view.presenter = presenter
        interactor.output = presenter

        return view
    }

}
