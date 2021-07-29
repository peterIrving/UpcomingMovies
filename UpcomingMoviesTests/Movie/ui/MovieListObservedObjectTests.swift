//
//  MovieListObservedObjectTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies
import Combine


let mockError = NSError(domain: "mock failure", code: 1, userInfo: nil)

class MovieListObservedObjectTests: XCTestCase {
    
    func testStatesUponSuccessRepoCall() throws {
        let observableObject = MovieListObservableObject(repo: SuccessMockMovieListRepo())
        let expectation = XCTestExpectation(description: "Publishes many value then finishes")
        var bag = Set<AnyCancellable>()
        var values: [MovieListStateEnum] = []
        
        observableObject.$state.sink(
            receiveValue: { value in
                values.append(value)
                if value == .Loaded(mockListViewModel) {
                    expectation.fulfill()
                }
            }).store(in: &bag)
        
        observableObject.loadList()
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(values, [.Idle,.Loading,.Loaded(mockListViewModel)])
    }
    
    func testStatesUponFailedRepoCall() throws {
        let observableObject = MovieListObservableObject(repo: FailedMockMovieListRepo())
        let expectation = XCTestExpectation(description: "Publishes many value then finishes")

        var bag = Set<AnyCancellable>()
        
        var values: [MovieListStateEnum] = []
        
        observableObject.$state.sink(
            receiveValue: { value in
                values.append(value)
                if value == .Failed(mockError.localizedDescription) {
                    expectation.fulfill()
                }
            }).store(in: &bag)
        
        observableObject.loadList()
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(values, [.Idle,.Loading,.Failed(mockError.localizedDescription)])
    }
}
