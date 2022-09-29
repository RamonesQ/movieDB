//
//  GenreModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation

struct GenreList: Codable {
	 let genres: [Genre]
}

struct Genre: Codable {
	 let id: Int?
	 let name: String?
}
