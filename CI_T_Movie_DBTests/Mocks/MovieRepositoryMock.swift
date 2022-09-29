//
//  CastRepositoryMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation
@testable import CI_T_Movie_DB

class MovieRepositoryMock: MovieRepositoryProtocol {
	
	var genreModel: GenreList?
	var movieModel: MovieResponse?
	var error: Error! = nil
	
	
	func getGenre(completion: @escaping (Result<GenreList, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(genreModel!))
			}
	}
	
	func getNowPlayingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(movieModel!))
			}
	}
	
	func getUpcommingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(movieModel!))
			}
	}
	
}
