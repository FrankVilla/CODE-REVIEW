//
//  RiskmethodsTests.swift
//  RiskmethodsTests
//
//  Created by Erinson Villarroel on 25/02/2022.
//

import XCTest
@testable import Riskmethods

class RiskmethodsTests: XCTestCase {
    
    var movieManager: MovieCell!
    
    override func setUp() {
        super.setUp()
        movieManager = MovieCell()
    }
    
    override func tearDown() {
        movieManager = nil
        super.tearDown()
    }
    
    func testInit_Values() {
       
        XCTAssertNotNil(movieManager.movieImage)
    }
  

}
