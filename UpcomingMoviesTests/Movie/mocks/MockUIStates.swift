//
//  MockUIStates.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation
@testable import UpcomingMovies

let mockIdleListState = MovieListStateEnum.Idle
let mockLoadingListState = MovieListStateEnum.Loading
let mockLoadedListState = MovieListStateEnum.Loaded(mockListViewModel)
let mockFailedListState = MovieListStateEnum.Failed("failed")

let mockIdleDetailState = MovieDetailStateEnum.Idle
let mockLoadingDetailState = MovieDetailStateEnum.Loading
let mockLoadedDetailState = MovieDetailStateEnum.Loaded(mockMovieDetailViewModel)
let mockFailedDetailState = MovieDetailStateEnum.Failed("failed")
