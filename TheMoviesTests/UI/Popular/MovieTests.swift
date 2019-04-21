//
//  MovieTests.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import XCTest
@testable import TheMovies

class MovieTests: XCTestCase {
    
    var client: HTTPClientSerivce!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = MockHTTPClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }
    
    func testMovieEntity() {
        let movie = getMovie()
        XCTAssertTrue(movie.id == 456740)
        XCTAssertTrue(movie.voteAverage == 5.2)
        XCTAssertTrue(movie.posterPath == "/nUXCJMnAiwCpNPZuJH2n6h5hGtF.jpg")
        XCTAssertEqual(movie.title, "Hellboy")
        XCTAssertTrue(movie.releaseDate == "2019-04-10")
    }
    
    private func getMovie() -> Movie {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "PopularMovies", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let popularMovies = try! JSONDecoder().decode(PopularMoviesResponse.self, from: data)
        return popularMovies.results[0]
    }
    
}
