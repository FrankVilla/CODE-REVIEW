//
//  PlayerTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 31.07.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class PlayerTests: XCTestCase {
    func testCanSeekBackwardsBy() {
        var player = MockPlayer()
        player.position = 10
        player.minPosition = -10

        XCTAssertTrue(player.canSeekBackwards(by: 19))
        XCTAssertFalse(player.canSeekBackwards(by: 20))
    }

    func testCanSeekForwardBy() {
        var player = MockPlayer()
        player.position = 10
        player.maxPosition = 40

        XCTAssertTrue(player.canSeekForward(by: 29))
        XCTAssertFalse(player.canSeekForward(by: 30))
    }
}
