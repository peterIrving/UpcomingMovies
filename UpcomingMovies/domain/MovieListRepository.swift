//
//  MovieListRepository.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

let productionMovieListRepository = MovieListRepositoryImpl()

protocol MovieListRepository {
    func fetchMovieList(completion: @escaping (Result<MovieListViewModel, Error>)->())
    func fetchMovieDetailsForId(id: Int, completion: @escaping (Result<MovieDetailViewModel, Error>)->())
}

class MovieListRepositoryImpl : MovieListRepository{

    
    var dataSource: MovieDataSource
    var movieListEntity: MovieListEntity?
    
    init(dataSource: MovieDataSource = MovieDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    //MARK: Dont coalescnce optional strings here
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
