//
//  DetailsModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 01/08/22.
//

import Foundation

struct MovieDetails: Decodable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
    }
}
