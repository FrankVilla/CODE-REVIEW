//
//  EventDetailsTests.swift
//  tv-iosTests
//
//  Created by Mac on 8/17/20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class EventDetailsTests: XCTestCase {
    func testEventGenreMissing() {
        let details = EventDetails()
        var event = Event.mock()
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.genre, "")
    }
    func testEventGenre() {
        var details = EventDetails()
        details.genre = genre
        var event = Event.mock()
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.genre, "\(genre)")
    }
    func testProductionInfoMissing() {
        let details = EventDetails()
        var event = Event.mock()
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.productionInfo, "")
    }
    func testProductionDateMissing() {
        var details = EventDetails()
        var event = Event.mock()
        details.productionLocations = productionLocations
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.productionInfo, "US,DE")
    }
    func testProductionLocationsMissing() {
        var details = EventDetails()
        var event = Event.mock()
        details.productionDate = productionDate
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.productionInfo, "2020")
    }
    func testProductionInfo() {
        var details = EventDetails()
        var event = Event.mock()
        details.productionDate = productionDate
        details.productionLocations = productionLocations
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.productionInfo, "2020 US,DE")
    }
    func testDurationInfo() {
        let event = Event.mock(startDate: startDate, endDate: endDate)
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.durationInfo, "30 min.")
    }
    func testDurationInfoHD() {
        var details = EventDetails()
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.durationInfo, "30 min.")
    }
    func testQualityInfo() {
        var details = EventDetails()
        details.isHD = true
        var event = Event.mock()
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.qualityInfo, quality)
    }
    func testEventDetails() {
        var details = EventDetails()
        details.genre = genre
        details.productionDate = productionDate
        details.productionLocations = productionLocations
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "Comedy | 2020 US,DE | 30 min. | HD")
    }
    func testEventDetailsMissingGenre() {
        var details = EventDetails()
        details.productionDate = productionDate
        details.productionLocations = productionLocations
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "2020 US,DE | 30 min. | HD")
    }
    func testEventDetailsMissingProductionDate() {
        var details = EventDetails()
        details.genre = genre
        details.productionLocations = productionLocations
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "Comedy | US,DE | 30 min. | HD")
    }
    func testEventDetailsMissingProductionLocations() {
        var details = EventDetails()
        details.genre = genre
        details.productionDate = productionDate
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "Comedy | 2020 | 30 min. | HD")
    }
    func testEventDetailsMissingProductionInfo() {
        var details = EventDetails()
        details.genre = genre
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "Comedy | 30 min. | HD")
    }
    func testEventDetailsMissingGenreAndProductionInfo() {
        var details = EventDetails()
        details.isHD = true
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "30 min. | HD")
    }
    func testEventDetailsGenreAndDuration() {
        var details = EventDetails()
        details.genre = genre
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "Comedy | 30 min.")
    }
    func testEventDetailsProductionDateAndDuration() {
        var details = EventDetails()
        details.productionDate = productionDate
        var event = Event.mock(startDate: startDate, endDate: endDate)
        event.details = details
        let viewModel = EventDetailsViewModel(event: event)
        XCTAssertEqual(viewModel.details, "2020 | 30 min.")
    }
}

extension EventDetailsTests {
    var genre: String {
        return "Comedy"
    }
    var productionDate: String {
        return "2020"
    }
    var productionLocations: [String] {
        return ["US", "DE"]
    }
    var startDate: Date {
        return Date().dateAtStartOf(.day)
    }
    var endDate: Date {
        return Date().dateAtStartOf(.day).add(minutes: 30)
    }
    var quality: String {
        return "HD"
    }
}

// Comedy | 2020 US,DE | 30 min. | HD
// 2020 US,DE | 30 min. | HD <-- missing genre
// Comedy | US,DE | 30 min. | HD <-- missing production date
// Comedy | 2020 | 30 min. | HD <-- missing production locations
// Comedy | 30 min. | HD <-- missing production info
