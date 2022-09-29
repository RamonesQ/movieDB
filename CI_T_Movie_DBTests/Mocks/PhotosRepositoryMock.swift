//
//  PhotosRepositoryMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation
@testable import CI_T_Movie_DB

class PhotosRepositoryMock: PhotosRepositoryProtocol {
	
	var photosModel: MovieImages?
	var error: Error! = nil
	
	func getPhotos(id: Int, completion: @escaping (Result<MovieImages, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(photosModel!))
			}
	}
}
