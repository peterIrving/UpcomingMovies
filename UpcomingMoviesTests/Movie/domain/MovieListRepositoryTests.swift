//
//  MovieListRepository.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/27/21.
//

import XCTest
@testable import UpcomingMovies

let successResponseModel =
    MovieListResponseModel(page: 1,
                           results: [
                            MovieResponseModel(id: 1,
                                               title: "first",
                                               adult: false,
                                               genreTitles: ["action", "comedy"],
                                               overview: "this is the overview",
                                               releaseDate:  Date(timeIntervalSinceReferenceDate: -123456789.0))
                           ])

let nilResponseModel = MovieResponseModel(id: 1, title: nil, adult: nil,genreTitles: nil,overview: nil,releaseDate: nil)

let coalescedMovieEntity = MovieEntity(id: 1, title: "n/a", adult: false, genreTitles: [], overview: "not available", releaseDate: Date())

let mockMovieListEntity =  MovieListEntity(
    movies: [
        mockMovieEntity
    ])

let mockMovieEntity = MovieEntity(
    id: 1,
    title: "first",
    adult: false,
    genreTitles: ["action", "comedy"],
    overview: "this is the overview",
    releaseDate: Date(timeIntervalSinceReferenceDate: -123456789.0)
)

let movieNotFoundError = NSError(domain: "movie not found", code: 1, userInfo: nil)

class SuccessfulMockMovieDataSource: MovieDataSource{
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>) -> Void) {
        completion(.success(successResponseModel))
    }
}

class FailedMockMovieDataSource: MovieDataSource{
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>) -> Void) {
        completion(.failure(NSError(domain: "mock error", code: 0, userInfo: nil )))
    }
}



class MovieListRepositoryTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRepositoryFetchListReturnsListViewModelOnSuccess() throws{
        let mockedDataSource = SuccessfulMockMovieDataSource()
        let movieListRepository = MovieListRepositoryImpl(dataSource: mockedDataSource)
        
        let expectation = XCTestExpectation(description: "Fetch movie list data and return MovieListViewModel")
        
        
        movieListRepository.fetchMovieList { result in
            
            switch (result ) {
            case .success(let movieListViewModel):
                XCTAssertEqual(movieListViewModel, MovieListViewModel(list: [MovieTileViewModel(movieId: 1, title: "first", subtitle: "action, comedy")]))
                expectation.fulfill()
                break
            case .failure(_):
                XCTFail()
                break
                
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testDatasourceNotNeededToBeCalledIfEntityExists() throws {
        let mockedDataSource = FailedMockMovieDataSource()
        let movieListRepository = MovieListRepositoryImpl(dataSource: mockedDataSource)
        
        movieListRepository.movieListEntity = mockMovieListEntity
        
        let expectation = XCTestExpectation(description: "Fetch movie list view model gets returned. FailedDataSource does not need to be called because entity is set")
        
        movieListRepository.fetchMovieList { result in
            
            switch (result ) {
            case .success(_):
                XCTAssertEqual(movieListRepository.movieListEntity, MovieListEntity(
                                movies: [
                                    MovieEntity(
                                        id: 1,
                                        title: "first",
                                        adult: false,
                                        genreTitles: ["action", "comedy"],
                                        overview: "this is the overview",
                                        releaseDate: Date(timeIntervalSinceReferenceDate: -123456789.0))
                                ]))
                expectation.fulfill()
                break
            case .failure(_):
                XCTFail()
                break
                
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testMovieListEntityIsStoredWhenMovieListApiCalledSuccessfully() throws {
        let mockedDataSource = SuccessfulMockMovieDataSource()
        let movieListRepository = MovieListRepositoryImpl(dataSource: mockedDataSource)
        XCTAssertEqual(movieListRepository.movieListEntity, nil)
        
        let expectation = XCTestExpectation(description: "Fetch movie list data and stores data as entity")
        
        movieListRepository.fetchMovieList { result in
            
            switch (result ) {
            case .success(_):
                XCTAssertEqual(movieListRepository.movieListEntity, mockMovieListEntity)
                expectation.fulfill()
                break
            case .failure(_):
                XCTFail()
                break
                
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testRepositoryFetchListReturnsErrorOnFailure() throws{
        let mockedDataSource = FailedMockMovieDataSource()
        let movieListRepository = MovieListRepositoryImpl(dataSource: mockedDataSource)
        
        let expectation = XCTestExpectation(description: "Fetch movie list data and receive Error")
        
        movieListRepository.fetchMovieList { result in
            switch (result ) {
            case .success(_):
                XCTFail()
                
                break
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (mock error error 0.)")
                expectation.fulfill()
                break
                
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    
    func testArrayStringPrintExtension()throws {
        let array = ["action", "comedy"]
        XCTAssertEqual(array.returnListWithCommasAsString(), "action, comedy")
    }
    
    func testSelectingMovieDetailsWithValidIDReturnsProperDetailsViewModel()throws {
        let movieListRepository = MovieListRepositoryImpl(dataSource: SuccessfulMockMovieDataSource())
        movieListRepository.movieListEntity = mockMovieListEntity
        let expectation = XCTestExpectation(description: "Fetch movie details returns details view model")
        
        movieListRepository.fetchMovieDetailsForId(id: 1) { result in
            switch (result ) {
            case .success(let movieDetailViewModel):
                XCTAssertEqual(MovieDetailViewModel.fromEntity(entity: mockMovieEntity), movieDetailViewModel)

                    expectation.fulfill()
                break
            case .failure(_):
                XCTFail()
                break
                
            }
        }
        wait(for: [expectation], timeout: 3)

    }
    
    func testSelectingMovieDetailsWithInvalidIDReturnsError()throws {
        let movieListRepository = MovieListRepositoryImpl(dataSource: SuccessfulMockMovieDataSource())
        movieListRepository.movieListEntity = mockMovieListEntity
        let expectation = XCTestExpectation(description: "Fetch movie details returns details view model")
        
        movieListRepository.fetchMovieDetailsForId(id: 2) { result in
            switch (result ) {
            case .success(_):
                XCTFail()
             
                break
            case .failure(let error):
            
                XCTAssertEqual(error as NSError, NSError(domain: "movie not found", code: 1, userInfo: nil))

                    expectation.fulfill()
                break
                
            }
        }
        wait(for: [expectation], timeout: 3)

    }
    
    func testMovieResponseModelWithNilValuesCoalesceToExpectedEntity() throws {
        let entity = MovieEntity.fromResponseModel(movieResponse: nilResponseModel)
        
        XCTAssertEqual(entity.id, coalescedMovieEntity.id)
        XCTAssertEqual(entity.adult, coalescedMovieEntity.adult)
        XCTAssertEqual(entity.genreTitles, coalescedMovieEntity.genreTitles)
        XCTAssertEqual(entity.title, coalescedMovieEntity.title)
        XCTAssertEqual(entity.overview, coalescedMovieEntity.overview)
        
        //MARK: mock date time
//        XCTAssertEqual(entity.releaseDate, coalescedMovieEntity.releaseDate)
    }
}
