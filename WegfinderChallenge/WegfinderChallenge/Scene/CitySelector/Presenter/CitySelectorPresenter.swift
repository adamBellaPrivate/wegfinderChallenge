//
//  CitySelectorPresenter.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import Foundation

class CitySelectorPresenter {

    weak var view: CitySelectorViewProtocol?
    let interactor: CitySelectorInteractorProtocol
    let router: CitySelectorRouterProtocol

    private let errorWorker: ErrorWorkerProtocol

    // MARK: - Lifecycle functions

    init(view: CitySelectorViewProtocol,
         interactor: CitySelectorInteractorProtocol,
         router: CitySelectorRouterProtocol,
         errorWorker: ErrorWorkerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.errorWorker = errorWorker
    }

}

// MARK: - Public class's functions

extension CitySelectorPresenter: CitySelectorPresenterProtocol {

    final func viewDidLoad() {
        interactor.loadCityList()
    }

    final func navigateToDetails(on city: Settlement) {
        Thread.executeOnMain { [weak self] in
            self?.router.navigateToDetails(on: city)
        }
    }

}

// MARK: - Interactor response's functions

extension CitySelectorPresenter: CitySelectorInteractorOutput {

    final func onDidLoadCityListSuccess(with items: [Settlement]) {
        Thread.executeOnMain { [weak self] in
            self?.view?.onShowSceneViewModel(with: CitySelectorViewModel(cityList: items))
        }
    }

    final func onDidLoadCityListFailure(with error: Error) {
        let errorMessage = errorWorker.perform(error: error)
        Thread.executeOnMain { [weak self] in
            self?.view?.onShowFailureAlert(with: errorMessage)
        }
    }

}

// MARK: - Private class's functions

private extension CitySelectorPresenter {}
