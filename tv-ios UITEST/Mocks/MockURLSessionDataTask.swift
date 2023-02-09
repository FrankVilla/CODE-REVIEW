//
//  MockURLSessionDataTask.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 06.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation

final class MockURLSessionDataTask: URLSessionDataTask {

    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    override var response: URLResponse? { self.mockResponse }
    override var error: Error? { self.mockError }

    var completionHandler: (Data?, URLResponse?, Error?) -> Void

    init(with completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // Not calling super here
        self.completionHandler = completionHandler
    }

    override func cancel() {}

    override func resume() {
        self.completionHandler(self.mockData, self.mockResponse, self.mockError)
    }
}
