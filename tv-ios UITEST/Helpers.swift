//
//  Helpers.swift
//  tv-iosTests
//
//  Created by Bartosz Koziel on 11/06/2019.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation

extension Date {
    init?(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = formatter.date(from: string) else { return nil }
        
        self.init(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate)
    }
}
