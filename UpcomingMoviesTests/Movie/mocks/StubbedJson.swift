//
//  StubbedJson.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation

let movieListStub = """
{
   "page":1,
   "results":[
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
      {
         "adult":false,
         "backdrop_path":"/keIxh0wPr2Ymj0Btjh4gW7JJ89e.jpg",
         "genre_ids":[
            28,
            12,
            53,
            878
         ],
         "id":497698,
         "original_language":"en",
         "original_title":"Black Widow",
         "overview":"Natasha Romanoff, also known as Black Widow, confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy and the broken relationships left in her wake long before she became an Avenger.",
         "popularity":5750.009,
         "poster_path":"/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg",
         "release_date":"2021-07-07",
         "title":"Black Widow",
         "video":false,
         "vote_average":8,
         "vote_count":3337
      }
    ]
}
""".data(using: .utf8)!

let invalideMovieStubBecauseDateTimeFormat = """

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
         "release_date":"2021-07-28T07:35:30+0000",
         "title":"Space Jam: A New Legacy",
         "video":false,
         "vote_average":7.8,
         "vote_count":1230
      }

""".data(using: .utf8)!
