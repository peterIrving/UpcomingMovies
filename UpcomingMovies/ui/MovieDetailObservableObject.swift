//
//  MovieDetailObservableObject.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

enum MovieDetailStateEnum : Equatable{
    case Idle
    case Loading
    case Loaded(MovieDetailViewModel)
    case Failed(String)
    
    static func ==(lhs: MovieDetailStateEnum, rhs: MovieDetailStateEnum)-> Bool {
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

class MovieDetailObservableObject: ObservableObject {
    @Published var state: MovieDetailStateEnum = MovieDetailStateEnum.Idle
    
    let movieListRepository: MovieListRepository
    
    init(repo: MovieListRepository) {
        movieListRepository = repo
    }
    
    func loadList(id: Int) {
        state = MovieDetailStateEnum.Loading
        movieListRepository.fetchMovieDetailsForId(id: id, completion:{[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetailViewModel):

                    self?.state = MovieDetailStateEnum.Loaded(movieDetailViewModel)
                case .failure(let error):

                    self?.state = MovieDetailStateEnum.Failed( error.localizedDescription)
                }
            }
        })
    }
}
