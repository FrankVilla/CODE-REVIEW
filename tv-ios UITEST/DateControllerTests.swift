//
//  tv_iosTests.swift
//  tv-iosTests
//
//  Created by Bartosz Koziel on 13/05/2019.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

class DateControllerTests: XCTestCase {
    let currentDate = Date(string: "10-06-2019 12:51:18")

    func testRangeDates() {
        let dateRange = DateController.calculateLiveRangeDates(for: currentDate!)
        
        let expectedStartDate = Date(string: "10-06-2019 06:51:18")
        let expectedEndDate = Date(string: "11-06-2019 18:51:18")
        XCTAssertEqual(dateRange.start, expectedStartDate)
        XCTAssertEqual(dateRange.end, expectedEndDate)
    }
}
