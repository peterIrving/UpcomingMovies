//
//  MockViewModels.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies


let mockMovieDetailViewModel = MovieDetailViewModel(id: 1,
                                          title: "first",
                                          ageReccomendationString: "ageRecomendationString",
                                          genreTitles: "action, comedy",
                                          overview: "this is the overview",
                                          releaseDateString: "releaseDateString")

let mockListViewModel = MovieListViewModel(list: [MovieTileViewModel(movieId: 1, title: "title", subtitle: "subtitle")])
