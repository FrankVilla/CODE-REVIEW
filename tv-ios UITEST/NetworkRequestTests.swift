//
//  NetworkRequestTests.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 06.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import XCTest
@testable import tv_ios

final class NetworkRequestTests: XCTestCase {

    func testExecute() throws {
        let networkRequest = MockNetworkRequest()
        networkRequest.deserializeResponse = "all good"
        var networkRequestResult: Result<MockNetworkRequest.ModelType>!
        let expectation = self.expectation(description: "Network request executed")
        networkRequest.execute { result in
            networkRequestResult = result
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error, error!.localizedDescription)
        }
        XCTAssertNotNil(networkRequestResult)
        let result = try networkRequestResult.get()
        XCTAssertEqual(result, "all good")
    }

    func testExecuteWithRepetitions() throws {
        let networkRequest = MockNetworkRequest()
        networkRequest.deserializeResponse = NSNumber(1)
        networkRequest.retryCount = 5
        var networkRequestResult: Result<MockNetworkRequest.ModelType>!
        let expectation = self.expectation(description: "Network request executed")
        networkRequest.execute { result in
            networkRequestResult = result
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 0.1) { error in
            XCTAssertNil(error, error!.localizedDescription)
        }
        XCTAssertNotNil(networkRequestResult)
        XCTAssertThrowsError(try networkRequestResult.get())
        XCTAssertEqual(networkRequest.retryCount, 0)

        // 1 execution + 5 retries = 6
        XCTAssertEqual(networkRequest.mockedSession.tasksCreated.count, 6)
    }

    func testUrlRequest() {
        let networkRequest = MockNetworkRequest()
        XCTAssertEqual(networkRequest.urlRequest.url?.absoluteString, networkRequest.url.absoluteString)
    }
}
