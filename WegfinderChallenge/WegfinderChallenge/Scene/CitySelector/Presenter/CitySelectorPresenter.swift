//
//  CitySelectorPresenter.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

class CitySelectorPresenter {

    weak var view: CitySelectorViewProtocol?
    let interactor: CitySelectorInteractorProtocol
    let router: CitySelectorRouterProtocol

    // MARK: - Lifecycle functions

    init(view: CitySelectorViewProtocol,
         interactor: CitySelectorInteractorProtocol,
         router: CitySelectorRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - Public class's functions

extension CitySelectorPresenter: CitySelectorPresenterProtocol {

    final func viewDidLoad() {

    }

    final func navigateToDetails() {
        router.navigateToDetails()
    }

}

// MARK: - Interactor response's functions

extension CitySelectorPresenter: CitySelectorInteractorOutput {

    func onDidLoadCityListSuccess() {
        #warning("TODO")
    }

    func onDidLoadCityListFailure(with error: Error) {
        #warning("TODO")
    }

}

// MARK: - Private class's functions

private extension CitySelectorPresenter {}
