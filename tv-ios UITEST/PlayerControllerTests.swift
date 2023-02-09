//
//  Replayable.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 31.07.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class PlayerControllerTests: XCTestCase {
    func testCurrentTime() {
        var playerController = MockPlayerController()
        playerController.startDate = playerController.currentDate

        // Current time might be negative
        playerController.utcPosition = playerController.currentDate.toMillis() - 1000
        XCTAssertEqual(playerController.currentTime, -1000)

        // Current time is the positive difference between the utc position and the start time
        playerController.utcPosition = playerController.currentDate.toMillis()
        XCTAssertEqual(playerController.currentTime, 0)
        playerController.utcPosition = playerController.currentDate.toMillis() + 1000
        XCTAssertEqual(playerController.currentTime, 1000)
    }

    func testDuration() {
        var playerController = MockPlayerController()
        playerController.startDate = playerController.currentDate
        playerController.endDate = playerController.currentDate.add(seconds: 1)
        playerController.recordingOffset = 1000
        XCTAssertEqual(playerController.duration, 2000)
    }

    func testHasPlaybackStarted() {
        var playerController = MockPlayerController()
        playerController.startDate = playerController.currentDate
        playerController.recordingOffset = 10000 // 10s

        playerController.utcPosition = playerController.currentDate.toMillis()
        XCTAssertTrue(playerController.hasPlaybackStarted)

        // 11s < recording offset => false
        playerController.utcPosition = playerController.currentDate.add(seconds: -11).toMillis()
        XCTAssertFalse(playerController.hasPlaybackStarted)
    }

    func testPlaybackProgress() {
        var playerController = MockPlayerController()
        playerController.startDate = playerController.currentDate
        playerController.utcPosition = playerController.currentDate.add(seconds: 10).toMillis()
        XCTAssertEqual(playerController.playbackProgress, 10000)
    }

    func testTotalProgress() {
        var playerController = MockPlayerController()

        playerController.startDate = playerController.currentDate.add(seconds: -200)
        playerController.endDate = playerController.currentDate.add(seconds: -100)
        XCTAssertEqual(playerController.maxProgress, 1.0, accuracy: 0.001)

        playerController.endDate = playerController.currentDate
        XCTAssertEqual(playerController.maxProgress, 1.0, accuracy: 0.001)

        playerController.endDate = playerController.currentDate.add(seconds: 200)
        XCTAssertEqual(playerController.maxProgress, 0.5, accuracy: 0.001)

        playerController.recordingOffset = 100000
        XCTAssertEqual(playerController.maxProgress, 0.6, accuracy: 0.001)
    }

    func testTrackPlayback() {
        var playerController = MockPlayerController()

        playerController.startDate = playerController.currentDate.add(seconds: -200)
        playerController.endDate = playerController.currentDate.add(seconds: 200)

        XCTAssertEqual(playerController.trackPlayback, 0)

        playerController.progress = 0.4
        XCTAssertEqual(playerController.trackPlayback, 160000)

        playerController.progress = 0.5
        XCTAssertEqual(playerController.trackPlayback, 200000)

        playerController.progress = 1.0
        XCTAssertEqual(playerController.trackPlayback, 200000)
    }
}
