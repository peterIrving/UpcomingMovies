//
//  MovieDetailView.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import SwiftUI

struct MovieDetailView: View {
    let id: Int
    let title:String
    
    @EnvironmentObject var detailObservable: MovieDetailObservableObject
    
    var body: some View {
        VStack{
            MovieDetailBody(state: detailObservable.state)
        }.onAppear {
            detailObservable.loadList(id: id)
        }.navigationBarTitle(Text(title),displayMode: .inline )
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
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4){
                            Text(viewModel.title).font(.title)
                            Text("In Theaters: " + viewModel.releaseDateString)
                        }
                        VStack(alignment: .leading, spacing: 6){
                            Text("Overview").font(.title2)
                            Divider()
                            Text(viewModel.overview).font(.body)
                        }
                        VStack(alignment: .leading, spacing: 6){
                            Text("Genre\(viewModel.genreTitles.count == 1 ? "" : "s")").font(.title2)
                            Divider()
                            Text(viewModel.genreTitles).font(.body)
                        }
                        VStack(alignment: .leading, spacing: 6){
                            Text("Age Recommendation").font(.title2)
                            Divider()
                            Text(viewModel.ageReccomendationString).font(.body)
                        }
                    }.frame(maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading).padding(16)
                }
            )
        default:
            return AnyView(ProgressView())
        }
    }
}


//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView( id: 1)
//    }
//}
