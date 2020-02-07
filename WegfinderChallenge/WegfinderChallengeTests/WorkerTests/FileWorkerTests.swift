//
//  FileWorkerTests.swift
//  WegfinderChallengeTests
//
//  Created by Adam Bella on 2/7/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import XCTest
@testable import WegfinderChallenge

class FileWorkerTests: XCTestCase {

    private var fileWorker: FileWorkerProtocol!

    override func setUp() {
        super.setUp()
        fileWorker = FileWorker()
        XCTAssertNotNil(fileWorker, "The system can't create this class")
    }

    func testReadCurrencyJSON() {
        fileWorker.fetchCityList { result in
            switch result {
            case .success(let items):
                XCTAssertEqual(items.count, 6)
                XCTAssertEqual(items.first?.name, "New York")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}
