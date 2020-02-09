//
//  CitySelectorInteractorTests.swift
//  WegfinderChallengeTests
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import XCTest
@testable import WegfinderChallenge

class CitySelectorInteractorTests: XCTestCase {

    private var interactor: CitySelectorInteractorProtocol!

    private lazy var loadCityListExpectation = self.expectation(description: "Load city list")

    override func setUp() {
        super.setUp()

        interactor = CitySelectorInteractor(fileWorker: FileWorker())
        interactor.output = self
        XCTAssertNotNil(interactor, "The system can't create this class")
    }

    func testLoadCityList() {
        interactor.loadCityList()
        wait(for: [loadCityListExpectation], timeout: 5)
    }

}

extension CitySelectorInteractorTests: CitySelectorInteractorOutput {

    func onDidLoadCityListSuccess(with items: [Settlement]) {
        XCTAssertFalse(items.isEmpty)
        XCTAssertEqual(items.count, 6)
        loadCityListExpectation.fulfill()
    }

    func onDidLoadCityListFailure(with error: Error) {
        loadCityListExpectation.fulfill()
    }

}
