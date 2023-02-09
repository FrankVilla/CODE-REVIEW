//
//  MockURLSession.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 06.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import Foundation

final class MockURLSession: URLSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    // Stores here the name of the tasks created for testing purposes
    var tasksCreated = [String]()

    override func dataTask(with url: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.tasksCreated.append("dataTaskWithUrl")
        let dataTask = MockURLSessionDataTask(with: completionHandler)
        dataTask.mockData = self.mockData
        dataTask.mockResponse = self.mockResponse
        dataTask.mockError = self.mockError
        return dataTask
    }

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.tasksCreated.append("dataTaskWithUrlRequest")
        let dataTask = MockURLSessionDataTask(with: completionHandler)
        dataTask.mockData = self.mockData
        dataTask.mockResponse = self.mockResponse
        dataTask.mockError = self.mockError
        return dataTask
    }
}
