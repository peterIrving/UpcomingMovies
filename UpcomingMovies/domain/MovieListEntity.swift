//
//  MovieListEntity.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

struct MovieListEntity: Equatable {

    let movies: [MovieEntity]
    static func == (lhs: MovieListEntity, rhs: MovieListEntity) -> Bool {
        return (lhs.movies == rhs.movies)
    }
    
    static func fromResponseModels(movieListResponseModel: MovieListResponseModel) -> MovieListEntity{
        return MovieListEntity(movies: movieListResponseModel.results.map({ movieResposne in
            return MovieEntity.fromResponseModel(movieResponse: movieResposne)
        }))
    }
    
}

struct MovieEntity: Equatable {
    let id: Int
    let title: String
    let adult: Bool
    let genreTitles: [String]
    let overview: String
    let releaseDate: Date
    
    static func == (lhs: MovieEntity, rhs: MovieEntity) -> Bool {
        return (lhs.id == rhs.id
                    && lhs.title == rhs.title
                    && lhs.adult == rhs.adult
                    && lhs.genreTitles == rhs.genreTitles
                    && lhs.overview == rhs.overview
                    && lhs.releaseDate == rhs.releaseDate)
    }
    
    static func fromResponseModel(movieResponse: MovieResponseModel)-> MovieEntity {
        return MovieEntity(id: movieResponse.id,
                           title: movieResponse.title ?? "n/a",
                           adult: movieResponse.adult ?? false,
                           genreTitles: movieResponse.genreTitles ?? [],
                           overview: movieResponse.overview ?? "not available",
                           releaseDate: movieResponse.releaseDate ?? Date())
    }
}
