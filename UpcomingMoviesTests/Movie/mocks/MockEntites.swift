//
//  MockEntites.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies

let coalescedMovieEntity = MovieEntity(id: 1,
                                       title: "n/a",
                                       adult: false,
                                       genreIds: [],
                                       overview: "not available",
                                       releaseDate: Date())

let mockMovieListEntity =  MovieListEntity(
    movies: [
        mockMovieEntity
    ])

let mockMovieEntity = MovieEntity(
    id: 1,
    title: "first",
    adult: false,
    genreIds: [28, 12],
    overview: "this is the overview",
    releaseDate: Date(timeIntervalSinceReferenceDate: -123456789.0)
)
