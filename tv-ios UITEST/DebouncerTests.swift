//
//  DebouncerTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-07-21.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class DebouncerTests: XCTestCase {

    func testExecution() {
        let debouncer = Debouncer()
        let expectation = self.expectation(description: "Execution from debouncer")
        var index: Int?
        expectation.isInverted = true
        expectation.expectedFulfillmentCount = 2
        for i in 1...10 {
            debouncer.execute {
                index = i
                expectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
        }
        XCTAssertEqual(index, 10)
    }
}
