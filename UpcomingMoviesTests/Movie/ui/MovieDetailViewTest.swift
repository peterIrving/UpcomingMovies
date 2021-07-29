//
//  MovieDetailViewTest.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import XCTest
@testable import UpcomingMovies
import ViewInspector

extension MovieDetailBody: Inspectable {}
extension MovieDetailView: Inspectable {}

class MovieDetailViewTest: XCTestCase {


    
    func testIdleStateDislaysProgressView() throws {
        let movieDetailBody = MovieDetailBody(state: mockIdleDetailState)

        let _ = try movieDetailBody.inspect().anyView(0).progressView()
    }

    func testLoadingStateDislaysProgressView() throws {
        let movieDetailBody = MovieDetailBody(state: mockLoadingDetailState)

        let _ = try movieDetailBody.inspect().anyView(0).progressView()
    }
 
    func testFailedStateDisplaysErrorMessage() throws {
        let movieDetailBody = MovieDetailBody(state: mockFailedDetailState)
        
        let _ = try
            movieDetailBody.inspect().anyView().find(text:"failed")
      
    }
    
    func testLoadedStateDisplaysProperData() throws {
        let movieDetailBody = MovieDetailBody(state: mockLoadedDetailState)
        
        let _ =  try
            movieDetailBody.inspect().anyView().find(text:"first")
      
      let _ =  try
           movieDetailBody.inspect().anyView().find(text:"ageRecomendationString")
     
        let _ = try
           movieDetailBody.inspect().anyView().find(text:"action, comedy")
     
        let _ = try
           movieDetailBody.inspect().anyView().find(text:"this is the overview")
        
        
       let _ = try
           movieDetailBody.inspect().anyView().find(text:"In Theaters: releaseDateString")
     
    }
    

  
}
