//
//  MovieDetailsObject.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 31/08/22.
//

import Foundation

class DetailsObject {
	//private var movieDetailsObj: MovieDetails
	
	let backdropPath: String
	let originalTitle, overview: String
	let runtime: String?
	let voteAverage: String?
	let genres: String
	let id: Int
	
	init(
		//movieDetailsObj: MovieDetails,
		runtimeFormattedString: String?,
		voteAverageFormatted: String?,
		backdropPath: String,
		originalTitle: String,
		overview: String,
		genresFormatted: String,
		id: Int
	){
		//self.movieDetailsObj = movieDetailsObj
		self.runtime = runtimeFormattedString
		self.voteAverage = voteAverageFormatted
		self.backdropPath = backdropPath
		self.originalTitle = originalTitle
		self.overview = overview
		self.genres = genresFormatted
		self.id = id
	}
}

