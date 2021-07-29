//
//  MovieListObservableObject.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

enum MovieListStateEnum : Equatable{
    case Idle
    case Loading
    case Loaded(MovieListViewModel)
    case Failed(String)
    
    static func ==(lhs: MovieListStateEnum, rhs: MovieListStateEnum)-> Bool {
        switch(lhs, rhs) {
        case (.Idle, .Idle):
            return true
        case (.Loading, .Loading):
            return true
        case (let .Loaded(vm1), let Loaded(vm2)):
            return vm1 == vm2
        case (let .Failed(s1), let .Failed(s2)):
            return s1 == s2
        default:
            return false
        }
    }
}

class MovieListObservableObject: ObservableObject {
    @Published var state: MovieListStateEnum = MovieListStateEnum.Idle
    
    let movieListRepository: MovieListRepository
    
    init(repo: MovieListRepository) {
        movieListRepository = repo
    }
    
    func loadList() {
        state = MovieListStateEnum.Loading
        movieListRepository.fetchMovieList {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieListViewModel):

                    self?.state = MovieListStateEnum.Loaded(movieListViewModel)
                case .failure(let error):

                    self?.state = MovieListStateEnum.Failed( error.localizedDescription)
                }
            }
        }
    }
}
