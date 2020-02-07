//
//  CitySelectorViewProtocol.swift
//  WegfinderChallenge
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

protocol CitySelectorViewProtocol: BaseViewControllerProtocol {

    var presenter: CitySelectorPresenterProtocol? { get set }

    func onShowSceneViewModel(with viewModel: CitySelectorViewModel)
    func onShowFailureAlert(with message: String)

}
