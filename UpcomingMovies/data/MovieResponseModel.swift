//
//  MovieResponseModel.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation


struct MovieListResponseModel: Codable {
    let page: Int
    let results: [MovieResponseModel]
}

struct MovieResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case genreIds = "genre_ids"
        case id
        case title
        case adult
        case overview
        case releaseDate = "release_date"
        
    }
    let id: Int
    let title: String?
    let adult: Bool?
    let genreIds: [Int]?
    let overview: String?
    let releaseDate: Date?
}
extension MovieResponseModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        adult = try container.decode(Bool.self, forKey: .adult)
        overview = try container.decode(String.self, forKey: .overview)
        
        
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            releaseDate = nil
        }
      }
}
