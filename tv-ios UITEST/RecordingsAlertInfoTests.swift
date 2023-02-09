//
//  RecordingsAlertInfoTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 04.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class RecordingsAlertInfoTests: XCTestCase {

    // swiftlint:disable function_body_length
    func test() {
        let recording = Recording(id: "id",
                                  profileId: "profileId",
                                  type: .single,
                                  seriesId: nil,
                                  startDate: Date(),
                                  endDate: Date(),
                                  startGuard: "startGuard",
                                  endGuard: "endGuard",
                                  titleId: "titleId",
                                  title: "title",
                                  episodeName: nil,
                                  duration: nil,
                                  coverPicture: nil,
                                  genre: nil,
                                  seriesNumber: nil,
                                  parentSeriesNumber: nil,
                                  channelId: "channelId",
                                  channelName: "channelName",
                                  seriesCount: 0,
                                  episodes: nil,
                                  eventId: nil,
                                  contentId: nil)
        var rowType = MockRecordingsRowType(cellType: UITableViewCell.self,
                                            type: .single,
                                            result: recording,
                                            profile: nil,
                                            isExtended: false)

        // Single recording
        var alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: false)
        XCTAssertEqual(alertInfo.actionTitle, "Löschen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Aufnahme von title löschen?")
        XCTAssertEqual(alertInfo.responseMessage, "Einzelaufnahme gelöscht")
        XCTAssertEqual(alertInfo.title, "Aufnahme löschen")

        // Single planned recording
        alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: true)
        XCTAssertEqual(alertInfo.actionTitle, "Abbrechen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Aufnahme von title abbrechen?")
        XCTAssertEqual(alertInfo.responseMessage, "Einzelaufnahme abgebrochen")
        XCTAssertEqual(alertInfo.title, "Aufnahme abbrechen")

        // Series recording
        rowType.type = .episode
        alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: false)
        XCTAssertEqual(alertInfo.actionTitle, "Löschen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Aufnahme von title -  S0E0 löschen?")
        XCTAssertEqual(alertInfo.responseMessage, "Einzelaufnahme gelöscht")
        XCTAssertEqual(alertInfo.title, "Episode löschen")

        // Series planned recording
        rowType.type = .episode
        alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: true)
        XCTAssertEqual(alertInfo.actionTitle, "Abbrechen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Aufnahme von title -  S0E0 abbrechen?")
        XCTAssertEqual(alertInfo.responseMessage, "Einzelaufnahme abgebrochen")
        XCTAssertEqual(alertInfo.title, "Episode abbrechen")

        // Main recording
        rowType.type = .main(isExtended: false)
        alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: false)
        XCTAssertEqual(alertInfo.actionTitle, "Löschen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Serien von title löschen?")
        XCTAssertEqual(alertInfo.responseMessage, "Serienaufnahme gelöscht")
        XCTAssertEqual(alertInfo.title, "Serienaufnahme löschen")

        // Main planned recording
        rowType.type = .main(isExtended: false)
        alertInfo = RecordingsAlertInfo(for:
            rowType, isPlanned: true)
        XCTAssertEqual(alertInfo.actionTitle, "Abbrechen")
        XCTAssertEqual(alertInfo.cancelTitle, "Schliessen")
        XCTAssertEqual(alertInfo.message, "Möchtest du die Serien von title abbrechen?")
        XCTAssertEqual(alertInfo.responseMessage, "Serienaufnahme abgebrochen")
        XCTAssertEqual(alertInfo.title, "Serienaufnahme abbrechen")
    }
}
