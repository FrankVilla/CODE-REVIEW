//
//  MockRecordingsRowType.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 04.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import UIKit
@testable import tv_ios

struct MockRecordingsRowType: RecordingsRowType {
    var cellType: UITableViewCell.Type
    var type: RecordingsViewController.Section.RowRecordingType
    var result: Recording
    var profile: String?
    var isExtended: Bool
}
