//
//  EventDetailsParametersTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 28.07.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class EventDetailsParametersTests: XCTestCase {
    func test() {
        let parameters = EventDetailsParameters(profileId: "profileId", resourceId: "resourceId")
        XCTAssertEqual(parameters.bodyFile, "EventDetails.xml")
    }
}
