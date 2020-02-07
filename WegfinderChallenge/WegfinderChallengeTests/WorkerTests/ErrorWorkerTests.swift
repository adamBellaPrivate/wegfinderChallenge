//
//  ErrorWorkerTests.swift
//  WegfinderChallengeTests
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import XCTest
@testable import WegfinderChallenge

class ErrorWorkerTests: XCTestCase {

    private var errorWorker: ErrorWorkerProtocol!

    override func setUp() {
        super.setUp()

        errorWorker = ErrorWorker()
        XCTAssertNotNil(errorWorker, "The system can't create this class")
    }

    func testPerformError() {
        let message = errorWorker.perform(error: AppError.invalidResponse)
        XCTAssertEqual(message, "general_error".localized)
    }

}
