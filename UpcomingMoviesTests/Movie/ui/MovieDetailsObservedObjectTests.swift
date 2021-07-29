//
//  MovieDetailsObservedObjectTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies
import Combine

let mockMovieDetailError = NSError(domain: "mock failure", code: 1, userInfo: nil)

class MovieDetailsObservedObjectTests: XCTestCase {

    func testStatesUponSuccessMovieFetch() throws {
        let observableObject = MovieDetailObservableObject(repo: SuccessMockMovieListRepo())
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
        let observableObject = MovieDetailObservableObject(repo: FailedMockMovieListRepo())
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
