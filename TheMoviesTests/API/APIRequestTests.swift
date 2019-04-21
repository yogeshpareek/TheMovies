//
//  APIRequestTest.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import XCTest
@testable import TheMovies

class APIRequestTests: XCTestCase {
    
    var client: HTTPClientSerivce!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = MockHTTPClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }
    
    func testPopularMoviesResponseSuccess() {
        let req = PopularMoviesRequest(page: 1)
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.page == 1)
                XCTAssertFalse(response.results.count == 10)
                XCTAssertTrue(response.totalPages == 991)
                XCTAssertTrue(response.totalResults == 19801)
                break
            case .failure(_):
                break
            }
        }
    }
    
}
