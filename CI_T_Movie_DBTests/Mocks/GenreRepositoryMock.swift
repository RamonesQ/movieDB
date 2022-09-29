//
//  GenreRepositoryMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation
@testable import CI_T_Movie_DB

class GenreRepositoryMock: GenreRepositoryProtocol {
	var genreModel: GenreList?
	var error: Error! = nil
	
	
	func getGenre(completion: @escaping (Result<GenreList, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(genreModel!))
			}
	}
	
}
