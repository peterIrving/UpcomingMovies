//
//  MockDataSource.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies

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
