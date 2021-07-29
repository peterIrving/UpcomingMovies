//
//  MovieListViewModels.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

struct MovieListViewModel: Equatable {
    let list: [MovieTileViewModel]
    
    static func ==(lhs: MovieListViewModel, rhs: MovieListViewModel) -> Bool {
        return (lhs.list == rhs.list)
    }
    
    static func fromEntity(entity: MovieListEntity)-> MovieListViewModel{
        return MovieListViewModel(list:
                                    entity.movies.map({ movieEntity in
                                        return MovieTileViewModel.fromEntity(movieEntity: movieEntity)
                                    })
        )
        
    }
    
}

struct MovieTileViewModel: Equatable, Identifiable {
    var id = UUID()
    let movieId: Int
    let title: String
    let subtitle: String
    
    static func ==(lhs: MovieTileViewModel, rhs: MovieTileViewModel) -> Bool {
        return (lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.movieId == rhs.movieId)
    }
    
    static func fromEntity(movieEntity: MovieEntity)-> MovieTileViewModel{
        return MovieTileViewModel(
            movieId: movieEntity.id,
            title: movieEntity.title,
            subtitle:  movieEntity.genreTitles.returnListWithCommasAsString())
        
    }
    
    
}

