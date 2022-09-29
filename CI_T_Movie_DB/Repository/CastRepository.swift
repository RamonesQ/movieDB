//
//  CastRepository.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation

protocol CastRepositoryProtocol {
	 func getCast(id: Int,completion: @escaping (Result<CastData, Error>) -> Void )
}

class CastRepository: CastRepositoryProtocol {
	 private let apiManager: APIManagerService
	 
	 init(apiManager: APIManagerService = APIManager()) {
		  self.apiManager = apiManager
	 }
	 
	 func getCast(id: Int, completion: @escaping (Result<CastData, Error>) -> Void) {
		  guard let url = MovieAPIService.getCastURLString(id: id) else { return }
		  
		  apiManager.fetchItems(url: url) { (result: Result<CastData, Error>) in
				switch result {
				case .success(let data):
					 completion(.success(data))
				case .failure(let error):
					 completion(.failure(error))
				}
		  }
	 }
}
