//
//  MockMovieListRepositories.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies

class SuccessMockMovieListRepo: MovieListRepository {
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {     completion(.success(mockMovieDetailViewModel))
        }
    }
    
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {     completion(.success(mockListViewModel))
        }
    }
}

class FailedMockMovieListRepo: MovieListRepository {
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.failure(mockError))
        }
    }
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {     completion(.failure(mockMovieDetailError))
        }
    }
}

