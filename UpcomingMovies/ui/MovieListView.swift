//
//  MovieListView.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject private var movieListObservable: MovieListObservableObject
    
    var body: some View {
        NavigationView {
            VStack{
                MovieListBody(state: movieListObservable.state)
            }.navigationTitle("Movies")
        }.onAppear(perform: movieListObservable.loadList)
    }
    
}

struct MovieListBody: View {
    let state: MovieListStateEnum
    
    var body: some View {
        switch state {
        case .Failed(let message):
            return AnyView(Text(message))
        case .Loaded(let viewModel):
            return  AnyView(
                List(viewModel.list) {
                    movie in
                    NavigationLink(destination: MovieDetailView(id: movie.movieId, title: movie.title).environmentObject(MovieDetailObservableObject(repo: productionMovieListRepository))) {
                        VStack(alignment: HorizontalAlignment.leading, spacing: 4) {
                            Text("\(movie.title)")
                            Text(movie.subtitle).font(.caption)
                        }.padding(4)
                    }
                }
                .listStyle(PlainListStyle())
  
            )
        default:
            return AnyView(ProgressView())
        }
    }
}
