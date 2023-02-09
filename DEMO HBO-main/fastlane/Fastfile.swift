// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
	func customLane() {
	desc("Description Ruen Test")
        lane :tests do
            run_tests(workspace: "Riskmethods.xcworkspace",
                      devices: ["iPhone 11"],
                      scheme: "RiskmethodsUITestsLaunchTests")
        end
	}
}
