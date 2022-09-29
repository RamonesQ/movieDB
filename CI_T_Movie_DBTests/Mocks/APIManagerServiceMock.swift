//
//  APIManagerMock.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 01/09/22.
//

import Foundation
@testable import CI_T_Movie_DB

class APIManagerServiceMock : APIManagerService {
	
	private(set) var fetchItemsCallCount = 0
	var fetchItemsHandler: ((URL, Any) -> ())?
	var error: Error? = nil
	var item: Any? = nil
	
	func fetchItems<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
		fetchItemsCallCount += 1
		if let fetchItemsHandler = fetchItemsHandler {
			fetchItemsHandler(url, completion)
		}
		if let error = error {
			completion(.failure(error))
		} else {
			completion(.success(item as! T))
		}
	}
	
	
}
