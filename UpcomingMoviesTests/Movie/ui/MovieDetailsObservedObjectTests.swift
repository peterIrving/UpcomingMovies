//
//  MovieDetailsObservedObjectTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies
import Combine

let mockMovieDetailViewModel = MovieDetailViewModel(id: 1,
                                          title: "first",
                                          adult: false,
                                          genreTitles: "action, comedy",
                                          overview: "this is the overview",
                                          releaseDate: Date(timeIntervalSinceReferenceDate: -123456789.0))

let mockMovieDetailError = NSError(domain: "mock failure", code: 1, userInfo: nil)


class SuccessDetailsMockMovieListRepo: MovieListRepository {
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {     completion(.success(mockMovieDetailViewModel))
        }
    }
    
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>) -> ()) {
      
    }
}

class FailedDetailsMockMovieListRepo: MovieListRepository {
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>) -> ()) {
      
    }
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>) -> ()) {
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {     completion(.failure(mockMovieDetailError))
        }
    }
}

class MovieDetailsObservedObjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStatesUponSuccessMovieFetch() throws {
        let observableObject = MovieDetailObservableObject(repo: SuccessDetailsMockMovieListRepo())
        let expectation = XCTestExpectation(description: "Publishes many value then finishes")
        var bag = Set<AnyCancellable>()
        var values: [MovieDetailStateEnum] = []
        
        observableObject.$state.sink(
            receiveValue: { value in
                values.append(value)
                if value == .Loaded(mockMovieDetailViewModel) {
                    expectation.fulfill()
                }
            }).store(in: &bag)
        
        observableObject.loadList(id: 1)
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(values, [.Idle,.Loading,.Loaded(mockMovieDetailViewModel)])
    }
    
    func testStatesUponFailedMovieFetch() throws {
        let observableObject = MovieDetailObservableObject(repo: FailedDetailsMockMovieListRepo())
        let expectation = XCTestExpectation(description: "Publishes many value then finishes")
        var bag = Set<AnyCancellable>()
        var values: [MovieDetailStateEnum] = []
        
        observableObject.$state.sink(
            receiveValue: { value in
                values.append(value)
                if value == .Failed(mockMovieDetailError.localizedDescription) {
                    expectation.fulfill()
                }
            }).store(in: &bag)
        
        observableObject.loadList(id: 1)
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(values, [.Idle,.Loading,.Failed(mockMovieDetailError.localizedDescription)])
    }

}
