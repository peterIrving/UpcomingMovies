//
//  MovieListResponseTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies



class MovieListResponseTests: XCTestCase {
    
    func testMovieListParsing() throws {
        
        let movieListResponse = try JSONDecoder().decode(MovieListResponseModel.self, from: movieListStub)
        
        XCTAssertEqual(movieListResponse.page, 1)
        XCTAssertEqual(movieListResponse.results.count, 2)
        
        try validateMovie(movie: movieListResponse.results[0],
                          movieId: 379686,
                          isAdult: false,
                          title: "Space Jam: A New Legacy",
                          genreIds:  [16, 35, 10751, 878],
                          overview:  "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
                          dateString: "2021-07-08")
        
        try validateMovie(movie: movieListResponse.results[1],
                          movieId: 497698,
                          isAdult: false,
                          title: "Black Widow",
                          genreIds: [28, 12, 53, 878],
                          overview:  "Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.",
                          dateString: "2021-07-07")
        
    }
    
    func validateMovie(movie: MovieResponseModel, movieId: Int, isAdult: Bool, title: String, genreIds: [Int], overview:String, dateString: String) throws {
        
        XCTAssertEqual(movie.id, movieId)
        XCTAssertEqual(movie.adult, isAdult)
        XCTAssertEqual(movie.title, title)
        XCTAssertEqual(movie.genreIds, genreIds)
        XCTAssertEqual(movie.overview, overview)
        
        let formatter = DateFormatter.yyyyMMdd
        if let mockedDate = formatter.date(from: dateString) {
            XCTAssertEqual(movie.releaseDate, mockedDate)
        }
    }
    
    func testMovieRepsonseFromJsonWithInvalidDateTimeFormatThrowsError()throws {

            let movieReponse = try  JSONDecoder().decode(MovieResponseModel.self, from: invalideMovieStubBecauseDateTimeFormat)
            XCTAssert(movieReponse.releaseDate == nil)
    }
    
    func testGenreIDConversion() {
        XCTAssertEqual(28.convertIntToGenre(), "Action")
        XCTAssertEqual(12.convertIntToGenre(), "Adventure")
        XCTAssertEqual(16.convertIntToGenre(), "Animation")
        XCTAssertEqual(35.convertIntToGenre(), "Comedy")
        XCTAssertEqual(80.convertIntToGenre(), "Crime")
        XCTAssertEqual(99.convertIntToGenre(), "Documentary")
        XCTAssertEqual(18.convertIntToGenre(), "Drama")
        XCTAssertEqual(10751.convertIntToGenre(), "Family")
        XCTAssertEqual(14.convertIntToGenre(), "Fantasy")
        XCTAssertEqual(36.convertIntToGenre(), "History")
        XCTAssertEqual(27.convertIntToGenre(), "Horror")
        XCTAssertEqual(10402.convertIntToGenre(), "Music")
        XCTAssertEqual(9648.convertIntToGenre(), "Mystery")
        XCTAssertEqual(878.convertIntToGenre(), "Science Fiction")
        XCTAssertEqual(10770.convertIntToGenre(), "TV Movie")
        XCTAssertEqual(53.convertIntToGenre(), "Thriller")
        XCTAssertEqual(10752.convertIntToGenre(), "War")
        XCTAssertEqual(37.convertIntToGenre(), "Western")
    }
}
