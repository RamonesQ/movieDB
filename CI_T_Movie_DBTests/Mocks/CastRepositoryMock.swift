//
//  CastRepositoryMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import Foundation
@testable import CI_T_Movie_DB

class CastRepositoryMock: CastRepositoryProtocol {
	
	var castModel: CastData?
	var error: Error! = nil
	
	func getCast(id: Int, completion: @escaping (Result<CastData, Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			} else {
			completion(.success(castModel!))
			}
}
}
