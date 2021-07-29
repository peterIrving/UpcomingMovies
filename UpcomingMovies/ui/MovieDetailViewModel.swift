//
//  MovieDetailViewModel.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

struct MovieDetailViewModel: Equatable {

    let id: Int
    let title: String
    let adult: Bool
    let genreTitles: String
    let overview: String
    let releaseDate: Date
    
    static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        return (lhs.id == rhs.id && lhs.title == rhs.title && lhs.adult == rhs.adult && lhs.genreTitles == rhs.genreTitles && lhs.overview == rhs.overview && lhs.releaseDate == rhs.releaseDate)
    }
    
    static func fromEntity(entity: MovieEntity)-> MovieDetailViewModel {
        return MovieDetailViewModel(id: entity.id, title: entity.title, adult: entity.adult, genreTitles: entity.genreTitles.returnListWithCommasAsString(), overview: entity.overview, releaseDate: entity.releaseDate)
    }
}
