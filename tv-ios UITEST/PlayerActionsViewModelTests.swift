//
//  PlayerActionsViewModelTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-08-09.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class PlayerActionsViewModelTests: XCTestCase {

    func testInitialState() {
        let viewModel = PlayerActionsViewModel()
        XCTAssertEqual(viewModel.delayOffset, 0)
        XCTAssertEqual(viewModel.description, "01:00–01:00")
        XCTAssertEqual(viewModel.duration, 0)
        XCTAssertEqual(viewModel.durationText, "0:00")
        XCTAssertEqual(viewModel.endDate, Date(seconds: 0))
        XCTAssertEqual(viewModel.episodeNumber, nil)
        XCTAssertEqual(viewModel.isRecordings, false)
        XCTAssertEqual(viewModel.position, 0)
        XCTAssertEqual(viewModel.positionText, "0:00")
        XCTAssertEqual(viewModel.progress, 0.0)
        XCTAssertEqual(viewModel.recordingOffset, 0)
        XCTAssertEqual(viewModel.seasonNumber, nil)
        XCTAssertEqual(viewModel.startDate, Date(seconds: 0))
        XCTAssertEqual(viewModel.subtitle, "")
        XCTAssertEqual(viewModel.title, "")
    }

    // swiftlint:disable function_body_length
    func testUpdateContentWithEvent() {
        var viewModel = PlayerActionsViewModel()
        var event = Event.mock(
            endDate: Date(seconds: 10000),
            titleId: "titleId",
            title: "title")
        viewModel.updateContent(with: event)
        XCTAssertEqual(viewModel.delayOffset, 0)
        XCTAssertEqual(viewModel.description, "01:00–03:46")
        XCTAssertEqual(viewModel.duration, 10000000)
        XCTAssertEqual(viewModel.durationText, "2:46:40")
        XCTAssertEqual(viewModel.endDate, Date(seconds: 10000))
        XCTAssertEqual(viewModel.episodeNumber, 0)
        XCTAssertEqual(viewModel.isRecordings, false)
        XCTAssertEqual(viewModel.position, 0)
        XCTAssertEqual(viewModel.positionText, "0:00")
        XCTAssertEqual(viewModel.progress, 0.0)
        XCTAssertEqual(viewModel.recordingOffset, 0)
        XCTAssertEqual(viewModel.seasonNumber, 0)
        XCTAssertEqual(viewModel.startDate, Date(seconds: 0))
        XCTAssertEqual(viewModel.subtitle, "")
        XCTAssertEqual(viewModel.title, "title")

        event = Event.mock(
            startDate: Date(seconds: 500),
            endDate: Date(seconds: 1000),
            title: "title2",
            episodeName: "episodeName",
            seriesId: "seriesId",
            parentSeriesId: "parentSeriesId")
        viewModel.updateContent(with: event)
        viewModel.position = -1000
        XCTAssertEqual(viewModel.delayOffset, 0)
        XCTAssertEqual(viewModel.description, "Staffel 0, Episode 0 - episodeName | 01:08–01:16")
        XCTAssertEqual(viewModel.duration, 500000)
        XCTAssertEqual(viewModel.durationText, "8:20")
        XCTAssertEqual(viewModel.endDate, Date(seconds: 1000))
        XCTAssertEqual(viewModel.episodeNumber, 0)
        XCTAssertEqual(viewModel.isRecordings, false)
        XCTAssertEqual(viewModel.position, -1000)
        XCTAssertEqual(viewModel.positionText, "-0:01")
        XCTAssertEqual(viewModel.progress, -0.002)
        XCTAssertEqual(viewModel.recordingOffset, 0)
        XCTAssertEqual(viewModel.seasonNumber, 0)
        XCTAssertEqual(viewModel.startDate, Date(seconds: 500))
        XCTAssertEqual(viewModel.subtitle, "episodeName")
        XCTAssertEqual(viewModel.title, "title2")

        viewModel.updateContent(with: nil)
        XCTAssertEqual(viewModel.delayOffset, 0)
        XCTAssertEqual(viewModel.description, "01:00–01:00")
        XCTAssertEqual(viewModel.duration, 0)
        XCTAssertEqual(viewModel.durationText, "0:00")
        XCTAssertEqual(viewModel.endDate, Date(seconds: 0))
        XCTAssertEqual(viewModel.episodeNumber, nil)
        XCTAssertEqual(viewModel.isRecordings, false)
        XCTAssertEqual(viewModel.position, -1000)
        XCTAssertEqual(viewModel.positionText, "-0:01")
        XCTAssertEqual(viewModel.progress, 0.0)
        XCTAssertEqual(viewModel.recordingOffset, 0)
        XCTAssertEqual(viewModel.seasonNumber, nil)
        XCTAssertEqual(viewModel.startDate, Date(seconds: 0))
        XCTAssertEqual(viewModel.subtitle, "")
        XCTAssertEqual(viewModel.title, "")
    }
}
