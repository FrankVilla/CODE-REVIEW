//
//  EventInfoTests.swift
//  tv-iosTests
//
//  Created by Javier.Alvargonzalez on 2020-08-09.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class EventInfoTests: XCTestCase {

    func testSeasonEpisodeWithSubtitleText() {
        let eventInfo = MockEventInfo()
        XCTAssertEqual(eventInfo.seasonEpisodeWithSubtitleText, "")

        eventInfo.episodeNumber = 10
        XCTAssertEqual(eventInfo.seasonEpisodeWithSubtitleText, "")
        eventInfo.seasonNumber = 6
        XCTAssertEqual(eventInfo.seasonEpisodeWithSubtitleText, "")
        eventInfo.subtitle = "subtitle"
        XCTAssertEqual(eventInfo.seasonEpisodeWithSubtitleText, "Staffel 6, Episode 10 - subtitle")
    }

    func testTimeText() {
        let eventInfo = MockEventInfo()
        XCTAssertEqual(eventInfo.timeText, "01:00–01:00")

        eventInfo.endDate = Date(seconds: 1111)
        XCTAssertEqual(eventInfo.timeText, "01:00–01:18")

        eventInfo.startDate = Date(seconds: 6666)
        XCTAssertEqual(eventInfo.timeText, "02:51–01:18")

        eventInfo.endDate = Date(seconds: 999999)
        XCTAssertEqual(eventInfo.timeText, "02:51–14:46")
    }
}
