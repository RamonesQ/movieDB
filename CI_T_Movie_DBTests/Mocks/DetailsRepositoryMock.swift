//
//  DetailsRepositoryMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation
@testable import CI_T_Movie_DB

class DetailsRepositoryMock: DetailsRepositoryProtocol {
	var detailsModel: MovieDetails?
	var error: Error! = nil
	
	func getMovieDetails(id: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(detailsModel!))
			}
	}
}
