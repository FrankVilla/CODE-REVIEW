//
//  MockPlayerController.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-08-02.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation
@testable import tv_ios

struct MockPlayerController: PlayerController {
    var event: Event?
    var player: Player = MockPlayer()
    var recording: Recording?
    var bufferDuration: Int = 0
    var bufferEnd: Date = Date(seconds: 0)
    var bufferStart: Date = Date(seconds: 0)
    var currentDate: Date = Date(seconds: 0)
    var delayOffset: Int = 0
    var endDate: Date = Date(seconds: 0)
    var offset: Int = 0
    var progress: Float = 0
    var recordingOffset: Int = 0
    var startDate: Date = Date(seconds: 0)
    var utcPosition: Int = 0
}
