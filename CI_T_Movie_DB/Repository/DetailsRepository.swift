//
//  DetailsRepository.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation

protocol DetailsRepositoryProtocol {
	func getMovieDetails(id: Int,completion: @escaping (Result<MovieDetails, Error>) -> Void )
}

class DetailsRepository: DetailsRepositoryProtocol {
	 private let apiManager: APIManagerService
	 
	 init(apiManager: APIManagerService = APIManager()) {
		  self.apiManager = apiManager
	 }
	 
	 func getMovieDetails(id: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
		  guard let url = MovieAPIService.getMovieDetailsURLString(id: id) else { return }
		  
		  apiManager.fetchItems(url: url) { (result: Result<MovieDetails, Error>) in
				switch result {
				case .success(let data):
					 completion(.success(data))
				case .failure(let error):
					 completion(.failure(error))
				}
		  }
	 }
}
