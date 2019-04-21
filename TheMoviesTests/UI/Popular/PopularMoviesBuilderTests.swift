//
//  PopularMoviesBuilderTests.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import XCTest
import UIKit
@testable import TheMovies

class PopularMoviesBuilderTests: XCTestCase {
    
    var vc: PopularMoviesVC!
    var presenter: PopularMoviesPresenter!
    var interactor: PopularMoviesInteractor!
    var wireFrame: PopularMoviesWireFrame!
    
    override func setUp() {
        super.setUp()
        vc = AppNavigationCordinator.shared.createMoviesModule() as? PopularMoviesVC
        presenter = vc.presenter as? PopularMoviesPresenter
        interactor = presenter.interactor as? PopularMoviesInteractor
        wireFrame = presenter.wireFrame as? PopularMoviesWireFrame
    }
    
    override func tearDown() {
        vc = nil
        presenter = nil
        interactor = nil
        wireFrame = nil
    }
    
    func testPopularMoviesModule() {
        XCTAssertTrue(vc != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(wireFrame != nil)
    }
    
    func testPopularMoviesModuleVC() {
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.presenter)
        XCTAssertTrue(vc.presenter is PopularMoviesPresenter)
    }
    
    func testPopularMoviesModulePresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.wireFrame)
        XCTAssertTrue(presenter.view is PopularMoviesVC)
        XCTAssertTrue(presenter.interactor is PopularMoviesInteractor)
        XCTAssertTrue(presenter.wireFrame is PopularMoviesWireFrame)
    }
    
    func testPopularMoviesModuleInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is PopularMoviesPresenter)
    }
    
    func testPopularMoviesModuleWireFrame() {
        XCTAssertNotNil(wireFrame)
    }
    
}

