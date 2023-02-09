//
//  Channel+Mock.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 03.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation
import UIKit
@testable import tv_ios

extension Channel {
    static func mock(id: String = "",
                     name: String = "",
                     channelNumber: Int = 0,
                     isAdult: Bool = false,
                     isNetworkRecordingAllowed: Bool = true,
                     isBlocked: Bool = false,
                     logoPicture: FetchableValue<UIImage>? = nil,
                     tstvEventCount: Int = 0,
                     isViewableOnCpe: Bool = true,
                     isOnRecordingList: Bool = false,
                     customProperties: [CustomProperty] = [],
                     products: [Product]? = nil,
                     rollingBuffers: [RollingBuffer]? = nil) -> Channel {
        return Channel(id: id,
                       name: name,
                       channelNumber: channelNumber,
                       isAdult: isAdult,
                       isNetworkRecordingAllowed: isNetworkRecordingAllowed,
                       isBlocked: isBlocked,
                       logoPicture: logoPicture,
                       tstvEventCount: tstvEventCount,
                       isViewableOnCpe: isViewableOnCpe,
                       isOnRecordingList: isOnRecordingList,
                       customProperties: customProperties,
                       products: products,
                       rollingBuffers: rollingBuffers)
    }
}
