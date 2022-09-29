//
//  GenreRepository.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation

protocol GenreRepositoryProtocol {
	func getGenre(completion: @escaping (Result<GenreList, Error>) -> Void )
}

class GenreRepository: GenreRepositoryProtocol {
	private let apiManager: APIManagerService
	
	init(apiManager: APIManagerService = APIManager()) {
		 self.apiManager = apiManager
	}
	
	func getGenre(completion: @escaping (Result<GenreList, Error>) -> Void) {
		 guard let url = MovieAPIService.getGenreURLString() else { return }
		 
		 apiManager.fetchItems(url: url) { (result: Result<GenreList, Error>) in
			  switch result {
			  case .success(let data):
					completion(.success(data))
			  case .failure(let error):
					completion(.failure(error))
			  }
		 }
	}
	
	
}
