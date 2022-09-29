//
//  PhotosRepository.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation

protocol PhotosRepositoryProtocol {
	func getPhotos(id: Int,completion: @escaping (Result<MovieImages, Error>) -> Void )
}

class PhotosRepository: PhotosRepositoryProtocol {
	 private let apiManager: APIManagerService
	 
	 init(apiManager: APIManagerService = APIManager()) {
		  self.apiManager = apiManager
	 }
	 
	func getPhotos(id: Int, completion: @escaping (Result<MovieImages, Error>) -> Void) {
		 guard let url = MovieAPIService.getPhotosURLString(id: id) else { return }
		 
		 apiManager.fetchItems(url: url) { (result: Result<MovieImages, Error>) in
			  switch result {
			  case .success(let data):
					completion(.success(data))
			  case .failure(let error):
					completion(.failure(error))
			  }
		 }
	}

}
