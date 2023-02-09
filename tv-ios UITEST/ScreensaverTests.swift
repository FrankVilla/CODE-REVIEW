//
//  ScreensaverTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 29.07.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class ScreensaverTests: XCTestCase {
    func test() {
        let owner1 = NSObject()

        // First disable screensaver, which should always succeed
        Screensaver.enable(false, owner: owner1)
        XCTAssertFalse(Screensaver.isEnabled)
        XCTAssertTrue(UIApplication.shared.isIdleTimerDisabled)

        // Enable screensaver with the same owner
        Screensaver.enable(true, owner: owner1)
        XCTAssertTrue(Screensaver.isEnabled)
        XCTAssertFalse(UIApplication.shared.isIdleTimerDisabled)

        // Disable screensaver with the same owner
        Screensaver.enable(false, owner: owner1)
        XCTAssertFalse(Screensaver.isEnabled)
        XCTAssertTrue(UIApplication.shared.isIdleTimerDisabled)

        // Enable screensaver with other owner, which shouldn't work
        let owner2 = NSObject()
        Screensaver.enable(true, owner: owner2)
        XCTAssertFalse(Screensaver.isEnabled)
        XCTAssertTrue(UIApplication.shared.isIdleTimerDisabled)

        // Disable screensaver with owner2, which should set the new owner
        Screensaver.enable(false, owner: owner2)
        XCTAssertFalse(Screensaver.isEnabled)
        XCTAssertTrue(UIApplication.shared.isIdleTimerDisabled)

        // Enable screensaver with owner2, which now it should work
        Screensaver.enable(true, owner: owner2)
        XCTAssertTrue(Screensaver.isEnabled)
        XCTAssertFalse(UIApplication.shared.isIdleTimerDisabled)
    }
}
