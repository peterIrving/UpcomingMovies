//
//  UpcomingMoviesApp.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/29/21.
//

import SwiftUI

@main
struct UpcomingMoviesApp: App {
    let movieListObservable = MovieListObservableObject(repo: productionMovieListRepository)

    var body: some Scene {
        WindowGroup {

            MovieListView().environmentObject(movieListObservable)
        }
    }
}
