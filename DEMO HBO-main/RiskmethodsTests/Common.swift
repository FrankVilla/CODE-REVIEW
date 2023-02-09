//
//  Common.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 28/02/2022.
//

import Foundation
import XCTest

class Common: XCTest {
    let application = XCUIApplication()
    func launchApplication() {
        application.launchArguments += ["BDD_TEST_MODE"]
        application.launchEnvironment["DEVICE_ID"] = "BDD00000-0000-0000-0000-000000000000"
        application.launch()
    }

    func verifyUIElementExists(_ type: XCUIElement.ElementType, withId id: String) {
        XCTAssert(application.descendants(matching: type)[id].exists)
    }

    @discardableResult
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        return element.waitForExistence(timeout: 14)
    }
}
