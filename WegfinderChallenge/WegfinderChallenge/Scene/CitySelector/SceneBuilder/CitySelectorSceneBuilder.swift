//
//  CitySelectorSceneBuilder.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

struct CitySelectorSceneBuilder {

    func buildScene() -> CitySelectorViewProtocol {
        let view = CitySelectorViewController()
        var interactor: CitySelectorInteractorProtocol = CitySelectorInteractor(fileWorker: FileWorker())
        let presenter = CitySelectorPresenter(view: view,
                                              interactor: interactor,
                                              router: CitySelectorRouter(view: view),
                                              errorWorker: ErrorWorker())

        view.presenter = presenter
        interactor.output = presenter

        return view
    }

}
