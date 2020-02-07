//
//  CitySelectorInteractor.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

class CitySelectorInteractor {

    weak var output: CitySelectorInteractorOutput?

    private let fileWorker: FileWorkerProtocol

    init(fileWorker: FileWorkerProtocol) {
        self.fileWorker = fileWorker
    }

}

// MARK: - Public class's functions

extension CitySelectorInteractor: CitySelectorInteractorProtocol {

    final func loadCityList() {
        fileWorker.fetchCityList { [weak self] result in
            switch result {
            case .success(let list):
                 self?.output?.onDidLoadCityListSuccess(with: list)
            case .failure(let error):
                self?.output?.onDidLoadCityListFailure(with: error)
            }
        }
    }

}
