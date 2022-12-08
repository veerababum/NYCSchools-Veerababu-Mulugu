//
//  _9860706_veerababuMulugu_NYCSchoolsUITestsLaunchTests.swift
//  19860706-veerababuMulugu-NYCSchoolsUITests
//
//  Created by Veerababu Mulugu on 12/5/22.
//

import XCTest

final class _9860706_veerababuMulugu_NYCSchoolsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
