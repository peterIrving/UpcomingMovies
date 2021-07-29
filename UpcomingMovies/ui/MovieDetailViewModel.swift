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
    let ageReccomendationString: String
    let genreTitles: String
    let overview: String
    let releaseDateString: String
    
    static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        return (lhs.id == rhs.id && lhs.title == rhs.title && lhs.ageReccomendationString == rhs.ageReccomendationString && lhs.genreTitles == rhs.genreTitles && lhs.overview == rhs.overview && lhs.releaseDateString == rhs.releaseDateString)
    }
    
    static func fromEntity(entity: MovieEntity)-> MovieDetailViewModel {
        return MovieDetailViewModel(id: entity.id,
                                    title: entity.title,
                                    ageReccomendationString: entity.adult  ? "Adult Audiences Only" : "Family Friendy" ,
                                    genreTitles: entity.genreIds.map({ id in
                                        return id.convertIntToGenre()
                                    }).returnListWithCommasAsString(),
                                    overview: entity.overview,
                                    releaseDateString: entity.releaseDate.toString())
    }
}
