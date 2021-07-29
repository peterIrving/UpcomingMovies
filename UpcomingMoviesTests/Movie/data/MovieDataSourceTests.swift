//
//  MovieDataSourceTest.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import XCTest
@testable import UpcomingMovies

class MovieDataSourceTests: XCTestCase {

    var movieDataSource: MovieDataSource!
      var expectation: XCTestExpectation!
//      let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts/42")!
        let apiURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1")!

      override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        movieDataSource = MovieDataSourceImpl(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }

    func testSuccessfulFetch () throws {
        
        // prepare mock
        
        // Prepare mock response.
        let page = 1
        let adult = false
        let genreIds = [16,35,10751,878]
        let id = 379686
        let overview = """
        When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.
        """
        // MARK: to decode poster_path
//        let posterPath = "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg"
        let releaseDateString = "2021-07-08"
        let title = "Space Jam: A New Legacy"
        
        let data = """
        {
           "page":\(page),
           "results":[
              {
                 "adult":\(adult),
                 "genre_ids":\(genreIds),
                 "id":\(id),
                 "overview":"\(overview)",
                 "release_date":"\(releaseDateString)",
                 "title":"\(title)"
              }
            ]
        }
        """.data(using: .utf8)!
        
        
        // end prepare mock
        
        MockURLProtocol.requestHandler = { request in
          guard let url = request.url, url == self.apiURL else {
//            throw APIResponseError.request
            throw NSError(domain: "incorrect url", code: 1, userInfo: nil)
          }
          
          let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, data)
        }
        
        movieDataSource.fetchList { result in
            switch result {
            case .success(let apiResponse):
                let movieResponse = apiResponse.results.first!
                XCTAssertEqual(apiResponse.page, page, "Incorrect page.")
                XCTAssertEqual(movieResponse.id,  id, "Incorrect id.")
                XCTAssertEqual(movieResponse.title, title, "Incorrect title.")
                XCTAssertEqual(movieResponse.overview, overview, "Incorrect overview.")
                XCTAssertEqual(movieResponse.adult,  adult, "Incorrect adult.")
                XCTAssertEqual(movieResponse.genreIds, genreIds, "Incorrect genreIds.")
                XCTAssertEqual(movieResponse.releaseDate, releaseDateString.toDate(), "Incorrect releaseDate.")
            case .failure(let error):
              XCTFail("Error was not expected: \(error)")
            }
            self.expectation.fulfill()
        }
                wait(for: [expectation], timeout: 5.0)

    }

    
    func testUnSuccessfulJSONParseDueToBadDataCallsBackFailure () throws {
        
        let badData = """
        ,,,,,,,,,
        kjbdxfkjhds;glknms;lknjm
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
          guard let url = request.url, url == self.apiURL else {
            throw NSError(domain: "incorrect url", code: 1, userInfo: nil)
          }
          
          let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, badData)
        }
        
        movieDataSource.fetchList { result in
            switch result {
            case .success(_):
                XCTFail("success not expected")
            case .failure(_):
                XCTAssert(true)
            }
            self.expectation.fulfill()
        }
                wait(for: [expectation], timeout: 5.0)

    }
    
    
    func testUnSuccessfulAPICallDueToNilDataCallsBackFailure () throws {

        MockURLProtocol.requestHandler = { request in
          throw  NSError(domain: "Api returned no data", code: 1, userInfo: nil)
        }
        
        movieDataSource.fetchList { result in
            switch result {
            case .success(_):
                XCTFail("success not expected")
            case .failure(_):
                XCTAssert(true)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

    }
}
