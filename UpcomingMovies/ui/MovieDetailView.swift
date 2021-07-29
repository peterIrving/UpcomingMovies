//
//  MovieDetailView.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import SwiftUI

struct MovieDetailView: View {
    let id: Int

    @EnvironmentObject var detailObservable: MovieDetailObservableObject
    
    var body: some View {
        VStack{
            MovieDetailBody(state: detailObservable.state)
        }.onAppear {
            detailObservable.loadList(id: id)
        }
    }
}

struct MovieDetailBody: View {
    let state: MovieDetailStateEnum
    
    var body: some View {
        switch state {
        case .Failed(let message):
            return AnyView(Text(message))
        case .Loaded(let viewModel):
            return  AnyView(
                VStack{
                    Text(viewModel.title)
                    //                    Text(viewModel.releaseDate)
//                    Text(viewModel.)
                    //                    Text(viewModel.adult)
                    //                    Text(viewModel.releaseDate)
                    Text(viewModel.overview)
                }
            )
        default:
            return AnyView(ProgressView())
        }
    }
}


//struct MovieDetailView: View {
//    let id: Int
//
//    @EnvironmentObject var detailObservable: MovieDetailObservableObject
//
//    var body: some View {
//        VStack{
//            buildView()
//        }.onAppear {
//            detailObservable.loadList(id: id)
//        }
//    }
//
//    func buildView()-> some View {
//        switch detailObservable.state {
//        case .Failed(let message):
//            return AnyView(Text(message))
//        case .Loaded(let viewModel):
//            return  AnyView(
//                VStack{
//                    Text(viewModel.title)
//                    //                    Text(viewModel.releaseDate)
////                    Text(viewModel.)
//                    //                    Text(viewModel.adult)
//                    //                    Text(viewModel.releaseDate)
//                    Text(viewModel.overview)
//                }
//            )
//        default:
//            return AnyView(ProgressView())
//        }
//    }
//}
//
//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView( id: 1)
//    }
//}
