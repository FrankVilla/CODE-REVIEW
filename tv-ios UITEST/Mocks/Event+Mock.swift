//
//  Event+Mock.swift
//  tv-iosTests
//
//  Created by Mac on 8/5/20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation
import UIKit
@testable import tv_ios

extension Event {
    static func mock(id: String = "",
                     startDate: Date = Date(seconds: 0),
                     endDate: Date = Date(seconds: 0),
                     titleId: String = "",
                     title: String = "",
                     episodeName: String? = "",
                     duration: Int? = 0,
                     coverPicture: FetchableValue<UIImage>? = nil,
                     genre: String? = "",
                     seriesId: String? = "",
                     seriesNumber: Int? = 0,
                     parentSeriesId: String? = "",
                     parentSeriesNumber: Int? = 0,
                     recordingStatus: RecordingStatus? = nil,
                     details: EventDetails? = nil) -> Event {
        return Event(id: id,
                     startDate: startDate,
                     endDate: endDate,
                     titleId: titleId,
                     title: title,
                     episodeName: episodeName,
                     duration: duration,
                     coverPicture: coverPicture,
                     genre: genre,
                     seriesId: seriesId,
                     seriesNumber: seriesNumber,
                     parentSeriesId: parentSeriesId,
                     parentSeriesNumber: parentSeriesNumber,
                     recordingStatus: recordingStatus, details: details)
    }
}
