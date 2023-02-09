//
//  RecommendationsParametersTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 28.07.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class RecommendationsParametersTests: XCTestCase {
    func test() {
        let parameters = RecommendationsParameters(profileId: "profileId",
                                                   resourceId: "resourceId",
                                                   contentSourceId: "contentSourceId")
        XCTAssertEqual(parameters.titleId, "[contentSourceId]resourceId")
        XCTAssertEqual(parameters.bodyFile, "Recommendations.xml")
    }
}
