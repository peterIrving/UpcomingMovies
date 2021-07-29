//
//  MovieResponseModel.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

/*
 {
 "adult":false,
 "backdrop_path":"/8s4h9friP6Ci3adRGahHARVd76E.jpg",
 "genre_ids":[
 16,
 35,
 10751,
 878
 ],
 "id":379686,
 "original_language":"en",
 "original_title":"Space Jam: A New Legacy",
 "overview":"When LeBron and his young son Dom are trapped in a digital space by a rogue A.I., LeBron must get them home safe by leading Bugs, Lola Bunny and the whole gang of notoriously undisciplined Looney Tunes to victory over the A.I.'s digitized champions on the court. It's Tunes versus Goons in the highest-stakes challenge of his life.",
 "popularity":7153.206,
 "poster_path":"/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
 "release_date":"2021-07-08",
 "title":"Space Jam: A New Legacy",
 "video":false,
 "vote_average":7.8,
 "vote_count":1230
 },
 */

// Use optionals here and coalesce to default value in constructor/conversion

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
//        genreTitles = genreInts.map { id in
//            return id.convertIntToGenre()
//        }
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
//            throw DecodingError.dataCorruptedError(forKey: .releaseDate,
//                  in: container,
//                  debugDescription: "Date string does not match format expected by formatter.")
            releaseDate = nil
        }
      }
}
