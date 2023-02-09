//
//  MockNetworkRequest.swift
//  tv-iosTests
//
//  Created by Erinson Villarroel on 06.08.20.
//  Copyright © 2020 Nexora AG. All rights reserved.
//

import UIKit
@testable import tv_ios

final class MockNetworkRequest: NetworkRequest {
    typealias ModelType = String
    typealias FailureType = String

    var mockedSession = MockURLSession()

    var retryCount: Int?
    var session: URLSession { self.mockedSession }
    var task: URLSessionDataTask?
    var url: URL = URL(string: "https://quickline.ch")!

    var deserializeResponse: Any?

    func deserialize(_ data: Data?) throws -> String {
        guard let response = self.deserializeResponse as? String else {
            throw NetworkError.errorOccured
        }
        return response
    }
}
