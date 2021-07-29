//
//  MovieDataSource.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

protocol MovieDataSource {
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>)->Void)
    
}

class MovieDataSourceImpl: MovieDataSource {
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>) -> Void) {
//        completion(.failure(NSError(domain: "my errror", code: 1, userInfo: nil)))
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1")!

//        var request = URLRequest(url: url)

        
        // MARK: Inject URL Session?
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let movieListResponse = try JSONDecoder().decode(MovieListResponseModel.self, from: data)
                    completion(.success(movieListResponse))
                } catch {
                    
                    completion(.failure(error))
                }
             

            } else if let error = error {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
