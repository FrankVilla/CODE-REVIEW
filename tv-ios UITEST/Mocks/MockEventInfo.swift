//
//  MockEventInfo.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 2020-08-09.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import UIKit
@testable import tv_ios

final class MockEventInfo: EventInfo {
    var title: String = ""
    var subtitle: String = ""
    var seasonNumber: Int?
    var episodeNumber: Int?
    var duration: Int = 0
    var startDate: Date = Date(seconds: 0)
    var endDate: Date = Date(seconds: 0)
}
