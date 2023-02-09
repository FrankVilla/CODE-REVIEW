//
//  RiskmethodsUITestsLaunchTests.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 25/02/2022.
//

import XCTest

class RiskmethodsUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testMovieList() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Popular"]/*[[".cells.buttons[\"Popular\"]",".buttons[\"Popular\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Upcoming"]/*[[".cells.buttons[\"Upcoming\"]",".buttons[\"Upcoming\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Top Rated"]/*[[".cells.buttons[\"Top Rated\"]",".buttons[\"Top Rated\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSelectdMovie() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).tap()
        app.navigationBars["Riskmethods.MovieDetailView"].buttons["Done"].tap()
    }
    
    func testSelectMovieWatched() {
        let app = XCUIApplication()
        let playRectangleOnButton = app.collectionViews.children(matching: .cell).element(boundBy: 1).buttons["play.rectangle.on"]
        playRectangleOnButton.tap()
        app.alerts["Movie Watched"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
