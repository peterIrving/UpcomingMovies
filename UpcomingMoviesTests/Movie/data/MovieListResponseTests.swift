//
//  MovieListResponseTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies



class MovieListResponseTests: XCTestCase {
    
    let movieListStub = """
    {
       "page":1,
       "results":[
          {
             "adult":false,
             "backdrop_path":"/8s4h9friP6Ci3adRGahHARVd76E.jpg",
             "genre_ids":[
                16,
                35,
                10751,
                878
             ],
             "id":379686,
             "original_language":"en",
             "original_title":"Space Jam: A New Legacy",
             "overview":"When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
             "popularity":7153.206,
             "poster_path":"/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
             "release_date":"2021-07-08",
             "title":"Space Jam: A New Legacy",
             "video":false,
             "vote_average":7.8,
             "vote_count":1230
          },
          {
             "adult":false,
             "backdrop_path":"/keIxh0wPr2Ymj0Btjh4gW7JJ89e.jpg",
             "genre_ids":[
                28,
                12,
                53,
                878
             ],
             "id":497698,
             "original_language":"en",
             "original_title":"Black Widow",
             "overview":"Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.",
             "popularity":5750.009,
             "poster_path":"/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
             "release_date":"2021-07-07",
             "title":"Black Widow",
             "video":false,
             "vote_average":8,
             "vote_count":3337
          }
        ]
    }
    """.data(using: .utf8)!
    
    let invalideMovieStubBecauseDateTimeFormat = """
    
          {
             "adult":false,
             "backdrop_path":"/8s4h9friP6Ci3adRGahHARVd76E.jpg",
             "genre_ids":[
                16,
                35,
                10751,
                878
             ],
             "id":379686,
             "original_language":"en",
             "original_title":"Space Jam: A New Legacy",
             "overview":"When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
             "popularity":7153.206,
             "poster_path":"/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
             "release_date":"2021-07-28T07:35:30+0000",
             "title":"Space Jam: A New Legacy",
             "video":false,
             "vote_average":7.8,
             "vote_count":1230
          }
    
    """.data(using: .utf8)!
    
    
    func testMovieListParsing() throws {
        
        let movieListResponse = try JSONDecoder().decode(MovieListResponseModel.self, from: movieListStub)
        
        XCTAssertEqual(movieListResponse.page, 1)
        XCTAssertEqual(movieListResponse.results.count, 2)
        
        try validateMovie(movie: movieListResponse.results[0],
                          movieId: 379686,
                          isAdult: false,
                          title: "Space Jam: A New Legacy",
                          genreTitles:  ["Animation", "Comedy", "Family", "Science Fiction"],
                          overview:  "When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
                          dateString: "2021-07-08")
        
        try validateMovie(movie: movieListResponse.results[1],
                          movieId: 497698,
                          isAdult: false,
                          title: "Black Widow",
                          genreTitles: ["Action", "Adventure", "Thriller", "Science Fiction"],
                          overview:  "Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.",
                          dateString: "2021-07-07")
        
    }
    
    func validateMovie(movie: MovieResponseModel, movieId: Int, isAdult: Bool, title: String, genreTitles: [String], overview:String, dateString: String) throws {
        
        XCTAssertEqual(movie.id, movieId)
        XCTAssertEqual(movie.adult, isAdult)
        XCTAssertEqual(movie.title, title)
        XCTAssertEqual(movie.genreTitles, genreTitles)
        XCTAssertEqual(movie.overview, overview)
        
        let formatter = DateFormatter.yyyyMMdd
        if let mockedDate = formatter.date(from: dateString) {
            XCTAssertEqual(movie.releaseDate, mockedDate)
        }
    }
    
    func testMovieRepsonseFromJsonWithInvalidDateTimeFormatThrowsError()throws {
        do {
            try JSONDecoder().decode(MovieResponseModel.self, from: invalideMovieStubBecauseDateTimeFormat)
        } catch {
            XCTAssert(error is DecodingError)
        }
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
