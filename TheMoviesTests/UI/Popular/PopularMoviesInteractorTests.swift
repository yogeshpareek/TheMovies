//
//  PopularMoviesInteractorTests.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 22/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import XCTest
@testable import TheMovies

class PopularMoviesInteractorTests: XCTestCase {
    
    var interactor: PopularMoviesInteractorMock!
    var presenter: PopularMoviesInteractorOutputMock!
    var client: HTTPClientSerivce!
    
    override func setUp() {
        presenter = PopularMoviesInteractorOutputMock()
        client = MockHTTPClient()
        interactor = PopularMoviesInteractorMock(presenter: presenter, client: client)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        presenter = nil
        client = nil
    }
    
    func testLoadPopularMovies() {
        interactor.makePopularMoviesRequest(page: 1)
        wait(for: 2)
        XCTAssertTrue(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }
    
    func testLoadPopularMoviesError() {
        interactor.makePopularMoviesRequest(page: 5)
        wait(for: 2)
        XCTAssertFalse(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }
    
}

class PopularMoviesInteractorOutputMock: PopularMoviesOutputInteractorProtocol {
    
    var success = false
    
    func onPopularMoviesSuccess(response: PopularMoviesResponse) {
        success = true
        XCTAssertFalse(response.results.isEmpty)
    }
    
    func onPopularMoviesError(error: APIError) {
        success = false
        
    }
    
}

class PopularMoviesInteractorMock: PopularMoviesInputInteractorProtocol {
    weak var presenter: PopularMoviesOutputInteractorProtocol?
    var client: HTTPClientSerivce
    var requestCalled: Bool = false
    
    init(presenter: PopularMoviesOutputInteractorProtocol, client: HTTPClientSerivce) {
        self.presenter = presenter
        self.client = client
    }
    
    func makePopularMoviesRequest(page: Int) {
        let req = PopularMoviesRequest(page: page)
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(let response):
                self.requestCalled = true
                self.presenter?.onPopularMoviesSuccess(response: response)
                break
            case .failure(let error):
                self.requestCalled = true
                self.presenter?.onPopularMoviesError(error: error)
                break
            }
        }
    }
    

}

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}


