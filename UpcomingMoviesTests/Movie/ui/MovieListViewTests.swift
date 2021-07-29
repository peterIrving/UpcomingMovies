//
//  MovieListViewTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/28/21.
//

import XCTest
@testable import UpcomingMovies
import ViewInspector


extension MovieListBody: Inspectable { }

class MovieListViewTests: XCTestCase {
    
    func testIdleStateDislaysProgressView() throws {
        let movieListBody = MovieListBody(state: mockIdleListState)
        
        let _ = try movieListBody.inspect().anyView(0).progressView()
    }
    
    func testLoadingStateDislaysProgressView() throws {
        let movieListBody = MovieListBody(state: mockLoadingListState)
        
        let _ = try movieListBody.inspect().anyView(0).progressView()
    }
    
    func testFailedStateDisplaysErrorMessage() throws {
        let movieListBody = MovieListBody(state: mockFailedListState)
        
        let _ = try
            movieListBody.inspect().anyView().find(text:"failed")
        
    }
    
    func testLoadedStateDisplaysListView() throws {
        let movieListBody = MovieListBody(state: mockLoadedListState)
        
        let _ = try
                    movieListBody.inspect().anyView().list()
     
        
    }
    
    
    
}

