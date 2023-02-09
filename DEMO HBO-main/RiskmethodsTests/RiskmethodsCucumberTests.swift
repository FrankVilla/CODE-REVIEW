//
//  RiskmethodsCucumberTests.swift
//  RiskmethodsUITests
//
//  Created by Erinson Villarroel on 28/02/2022.
//

import Foundation
import Cucumberish

@objc class RiskmethodsCucumberTests: NSObject {
    
    static let elementQueryTimeout: TimeInterval = 10.0
    
    @objc class func cucumberishSwiftInit() {
        var application: XCUIApplication!
       
        beforeStart { () -> Void in
            application = XCUIApplication()

        }
        before { (scenario) in
            guard scenario != nil else {
                CCISAssert(scenario != nil, "Scenario is nil")
                return }
        }
    
        Given("The app is started") { (_, _) -> Void in
            Common().launchApplication()

        }
        let bundle = Bundle(for: RiskmethodsCucumberTests.self)
        let tags = ["ios"]
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: tags, excludeTags: nil)
    }
}
