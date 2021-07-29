//
//  MockResponseModels.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies

let successResponseModel =
    MovieListResponseModel(page: 1,
                           results: [
                            MovieResponseModel(id: 1,
                                               title: "first",
                                               adult: false,
                                               genreIds: [28, 12],
                                               overview: "this is the overview",
                                               releaseDate:  Date(timeIntervalSinceReferenceDate: -123456789.0))
                           ])

let nilResponseModel = MovieResponseModel(id: 1, title: nil, adult: nil,genreIds: nil,overview: nil,releaseDate: nil)
