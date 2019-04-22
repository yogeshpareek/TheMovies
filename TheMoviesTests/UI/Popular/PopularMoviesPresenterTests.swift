//
//  PopularMoviesPresenterTests.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 22/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import XCTest
@testable import TheMovies

class PopularMoviesPresenterTests: XCTestCase {
   
    var interactor: PopularMoviesInteractorMock!
    var presenter: PopularMoviesPresenterMock!
    var view: PopularMoviesVCMock!
    var wireframe: PopularMoviesWireFrameMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = PopularMoviesPresenterMock()
        let client = MockHTTPClient()
        interactor = PopularMoviesInteractorMock(presenter: presenter, client: client)
        wireframe = PopularMoviesWireFrameMock()
        view = PopularMoviesVCMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.wireFrame = wireframe
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        view = nil
        interactor = nil
        wireframe = nil
    }
    
    func testShowLoadPopularMovies() {
        presenter.viewDidLoad()
        wait(for: 2)
        XCTAssertTrue(presenter.loadPopularMoviesSuccess)
        XCTAssertTrue(view.showPopularMovies)
    }
    
    func testInsertLoadPopularMovies() {
        presenter.viewDidLoad()
        wait(for: 2)
        presenter.willDisplayCell(at: IndexPath(row: 18, section: 0))
        wait(for: 2)
        XCTAssertTrue(presenter.loadPopularMoviesSuccess)
        XCTAssertTrue(presenter.willDisplayCalled)
        XCTAssertTrue(view.insertPopularMovies)
    }

    func testDidSeletMovie() {
        presenter.viewDidLoad()
        wait(for: 2)
        presenter.didSeletMovie(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenter.seletMovie)
    }

}

class PopularMoviesVCMock: BaseUIViewController, PopularMoviesVCProtocol {
    
    var presenter: PopularMoviesPresenterProtocol?
    var showPopularMovies: Bool = false
    var insertPopularMovies: Bool = false
    var viewModel: MovieViewModel?
    
    init(presenter: PopularMoviesPresenterMock) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorView(type: EmptyErrorType) {}
    
    func showPopularMovies(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        XCTAssertFalse(viewModel.data.isEmpty)
        XCTAssertTrue(viewModel.moviesCount == 20)
        showPopularMovies = true
    }
    
    func insertPopularMovies(at indexPaths: [IndexPath]) {
        XCTAssertFalse(viewModel?.data.isEmpty ?? true)
        XCTAssertTrue(viewModel?.moviesCount == 20)
        insertPopularMovies = true
    }
    
}

class PopularMoviesWireFrameMock: PopularMoviesWireFrameProtocol {
    var movieDetailSuccess: Bool = false
    
    func pushMovieDetail(view: PopularMoviesVCProtocol, movie: Movie) {
        movieDetailSuccess = true
    }
}

class PopularMoviesPresenterMock: PopularMoviesPresenterProtocol, PopularMoviesOutputInteractorProtocol {
    
    weak var view: PopularMoviesVCProtocol?
    var interactor: PopularMoviesInputInteractorProtocol?
    var wireFrame: PopularMoviesWireFrameProtocol?
    var loadPopularMoviesSuccess: Bool = false
    var seletMovie: Bool = false
    var willDisplayCalled: Bool = false
    private var moviesViewModel: MovieViewModel = MovieViewModel(pageSize: 20)
    
    func retryLoadPopularMovies() {}
    
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            willDisplayCalled = true
            loadPopularMovies()
        }
    }
    
    func didSeletMovie(at indexPath: IndexPath) {
        wireFrame?.pushMovieDetail(view: view!, movie: moviesViewModel.movie(at: indexPath))
        seletMovie = true
    }
    
    func onPopularMoviesSuccess(response: PopularMoviesResponse) {
        loadPopularMoviesSuccess = true
        if response.page == 1 {
            XCTAssertFalse(response.results.isEmpty)
        } else {
            XCTAssertTrue(response.results.isEmpty)
        }
        moviesViewModel.success(objects: response.results)
        if response.page == 1 {
            view?.showPopularMovies(viewModel: moviesViewModel)
        } else {
            let previousCount = moviesViewModel.moviesCount - response.results.count
            let totalCount = moviesViewModel.moviesCount
            let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
                return IndexPath(item: $0, section: 0)
            }
            view?.insertPopularMovies(at: indexPaths)
        }
    }
    
    func onPopularMoviesError(error: APIError) {
       loadPopularMoviesSuccess = false
    }
    
    func viewDidLoad() {
        loadPopularMovies()
    }
    
    private func loadPopularMovies() {
        interactor?.makePopularMoviesRequest(page: moviesViewModel.page)
    }
    
    func viewWillAppear() {}
    
}


