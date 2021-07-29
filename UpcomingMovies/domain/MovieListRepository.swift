//
//  MovieListRepository.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation


protocol MovieListRepository {
  
    /// If Repository does not have a stored MovieListEntity, Request MovieListReponseModel from MovieDataSource, Converts ResponseModel into MovieListEntity and stores entity In Repository,
    /// Converts MovieListEntity into MovieListViewModel then Fires completion with either a MovieListViewModel or an Error
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>)->())
    
    /// Fetches Movie Entity from Repositories Stored Entity for requested ID. If ID Exists, completion called with MovieDetailViewModel, if it does not exist, compeletion is called with Error
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>)->())
}

class MovieListRepositoryImpl : MovieListRepository{
    
    var dataSource: MovieDataSource
    var movieListEntity: MovieListEntity?
    
    init(dataSource: MovieDataSource = MovieDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>) -> ()) {
       if movieListEntity == nil {
            dataSource.fetchList {[weak self] response in
                switch response {
                case .success(let movieListResponseModel) :
                
                    self?.movieListEntity = MovieListEntity.fromResponseModels(movieListResponseModel:  movieListResponseModel)

                    self?.movieListViewModelCallback { result in
                        completion(result)
                    }
                   
                case.failure(let error):
                    completion(.failure(error))
                }
            }
            return
        }
        
        movieListViewModelCallback { result in
            completion(result)
        }
       
    }
    
    func movieListViewModelCallback(completion: @escaping (Result<MovieListViewModel, Error>) -> ())  {
        if let entity = movieListEntity {
            completion(.success(MovieListViewModel.fromEntity(entity: entity)))
        } else {
            completion(.failure(NSError(domain: "movie list not found", code: 1, userInfo: nil)))
        }
    }
    
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>)->()) {
        if let movie = movieListEntity?.movies.first(where: {$0.id == id}) {
            completion(.success(MovieDetailViewModel.fromEntity(entity: movie)))
        } else {
            completion(.failure( NSError(domain: "movie not found", code: 1, userInfo: nil)))
        }
    }

}
