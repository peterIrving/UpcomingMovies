//
//  MovieDataSource.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

protocol MovieDataSource {
    /// Fetches List of Movie Objects and invokes compeltion with a MovieListResponseModel or an Error
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>)->Void)
}

class MovieDataSourceImpl: MovieDataSource {
    
    let urlSession: URLSession
      
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchList(completion: @escaping (Result<MovieListResponseModel, Error>) -> Void) {

        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1")!

        let task = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let movieListResponse = try JSONDecoder().decode(MovieListResponseModel.self, from: data)
                    completion(.success(movieListResponse))
                } catch {
                    
                    completion(.failure(error))
                }
            }
            if let error = error {
                completion(.failure(NSError(domain: "Api returned no data \(error)", code: 1, userInfo: nil)))
            }}
        task.resume()
    }
}
