//
//  QLPlayerTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-08-02.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class QLPlayerTests: XCTestCase {

    func testAudioIndex() {
        let languages = ["a", "b", "c", "d"]
        XCTAssertEqual(QLPlayer.audioIndex("a", languages), Int32(0))
        XCTAssertEqual(QLPlayer.audioIndex("b", languages), Int32(1))
        XCTAssertEqual(QLPlayer.audioIndex("c", languages), Int32(2))
        XCTAssertEqual(QLPlayer.audioIndex("d", languages), Int32(3))
        XCTAssertEqual(QLPlayer.audioIndex("e", languages), Int32(0))
    }
}
