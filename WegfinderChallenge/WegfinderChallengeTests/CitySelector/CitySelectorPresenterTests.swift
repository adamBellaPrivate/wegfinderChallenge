//
//  CitySelectorPresenterTests.swift
//  WegfinderChallengeTests
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import XCTest
@testable import WegfinderChallenge

class CitySelectorPresenterTests: XCTestCase {

    private let rootViewController = UIViewController().embedInNavigationController()

    internal var presenter: CitySelectorPresenterProtocol?

    private lazy var viewDidLoadExpectation = self.expectation(description: "ViewDidLoad")
    private lazy var navigateToDetails = self.expectation(description: "navigateToDetails")

    override func setUp() {
        super.setUp()

        let interactor = CitySelectorInteractor(fileWorker: FileWorker())
        let presenter = CitySelectorPresenter(view: self,
                                              interactor: interactor,
                                              router: self,
                                              errorWorker: ErrorWorker())
        self.presenter = presenter
        interactor.output = presenter

        XCTAssertNotNil(presenter, "The system can't create this class")
        XCTAssertNotNil(presenter.view, "ViewProtocol has not initialized yet!")
    }

    func testViewDidLoad() {
        presenter?.viewDidLoad()
        wait(for: [viewDidLoadExpectation], timeout: 5)
    }

    func testNavigationTriggerEvent() {
        presenter?.navigateToDetails(on: City(name: "New York"))
        wait(for: [navigateToDetails], timeout: 5)
    }

}

extension CitySelectorPresenterTests: CitySelectorViewProtocol {

    func onShowSceneViewModel(with viewModel: CitySelectorViewModel) {
        XCTAssertEqual(viewModel.cityList.count, 6)
        viewDidLoadExpectation.fulfill()
    }

    func onShowFailureAlert(with message: String) {
        XCTAssertFalse(message.isEmpty, "Missing error message")
        viewDidLoadExpectation.fulfill()
    }

    var presentable: UIViewController {
        return rootViewController
    }

}

extension CitySelectorPresenterTests: CitySelectorRouterProtocol {

    var view: CitySelectorViewProtocol? {
        return self
    }

    func navigateToDetails(on city: City) {
        XCTAssertEqual(city.name, "New York")
        navigateToDetails.fulfill()
    }

}
