//
//  CommonStepDefinitions.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 28/02/2022.
//

import XCTest
import Cucumberish

class CommonStepDefinitions: NSObject {

    fileprivate var application : XCUIApplication!

    fileprivate func elementByLabel(_ label : String, type: String) -> XCUIElement {
        var elementQurey : XCUIElementQuery!
        switch(type){
        case "button":
            elementQurey = application.buttons
        case "label":
            elementQurey = application.staticTexts
        case "tab":
            elementQurey = application.tabs
        case "textView", "text view":
            elementQurey = application.textViews
        case "view":
            elementQurey = application.otherElements
        default: elementQurey = application.otherElements
        }
        return elementQurey[label]
    }

    fileprivate func setup(_ application: XCUIApplication) {
        self.application = application

        Given("The app is started") {  (args, userInfo) in
            Common().launchApplication()
        }
                
        Given ("I launched an App") { (args, userInfo) in
            Common().launchApplication()
         }
        
         MatchAll("I terminated an App") { (args, userInfo) in
             application.terminate()
         }

         MatchAll("^I see an alert with title \"([^\\\"]*)\" and clicked \"([^\\\"]*)\" action$") { (args, userInfo) in
             let alert = application.alerts[(args?[0])!]
             alert.buttons[(args?[0])!].tap()
         }

         MatchAll("^I allow system alert with  \"([^\\\"]*)\" description$") { (args, userInfo) in
             let alertDescription = args?[0]
             XCTestCase().addUIInterruptionMonitor(withDescription: alertDescription!) { (alert) -> Bool in
                 alert.buttons["Done"].tap()
                 return true
             }
             XCUIApplication().tap()
         }

         MatchAll("^I should see screen with \"([^\\\"]*)\" cells$") { (args, userInfo) in
             let cellCount = args![0]
             let expectedCellCount: UInt = UInt(cellCount)!
             let appCellCount = application.cells.count
            XCTAssertEqual(expectedCellCount, UInt(appCellCount), "Comparing  Cell Count")
         }

         MatchAll("^I check \"([^\\\"]*)\" checkbox$") { (args, userInfo) in
             let checkBox = args?[0]
             application.checkBoxes[checkBox!].tap()
         }
        
        MatchAll("^I tap (?:the )?\"([^\\\"]*)\" (button|label|tab|view|field|textView)$") { (args, userInfo) -> Void in
            let label = args?[0]
            let type = args?[1]
            self.elementByLabel(label!, type: type!).tap()
        }

        MatchAll("^I tap (?:the )?\"([^\\\"]*)\" (button|label|tab|view) ([1-9]{1}) time(?:s)?$") { (args, userInfo) -> Void in
            let label = args?[0]
            let type = args?[1]
            let times = NSString(string: (args?[2])!).integerValue
            let element = self.elementByLabel(label!, type: type!)
            for _ in 0 ..< times{
                element.tap()
            }
        }
    }

    class func setup(_ application: XCUIApplication)
    {
        CommonStepDefinitions().setup(application)
    }
}
