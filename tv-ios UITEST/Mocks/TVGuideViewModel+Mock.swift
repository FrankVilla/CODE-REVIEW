//
//  MockTVGuideModel.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 03.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation
@testable import tv_ios

extension TVGuideViewModel {
    static func mock(with channels: [Channel] = []) -> TVGuideViewModel {
        return TVGuideViewModel(with: channels)
    }
}
