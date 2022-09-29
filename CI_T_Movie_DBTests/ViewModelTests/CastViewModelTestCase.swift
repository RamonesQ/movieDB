//
//  CastViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 29/08/22.
//

import XCTest
import Combine
@testable import CI_T_Movie_DB

class CastViewModelTestCase: XCTestCase {
	var viewModel: CastViewModel!
	let apiMock = APIManagerServiceMock()
	let mockRepository = CastRepositoryMock()
	var cancellables: Set<AnyCancellable> = []
	
	let cast = CastData(id: 38, cast: [Cast(name: "Elijah Wood", profilePath: "/2332asa", castID: 25, character: "Frodo Baggins")])
	
	override func setUp() async throws {
		viewModel = CastViewModel(castRepository: mockRepository)
	}
	
	func test_success(){
		//given
		mockRepository.castModel = cast
		// then
		viewModel.castSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.cast.count, 1)
			}).store(in: &cancellables)
		//when
		viewModel.fetchCast(id: 1)
	}
	func testCastRepository(){
		mockRepository.error = NSError(domain: "", code: 404)
		apiMock.fetchItemsHandler = { _ , _ in
		}
		mockRepository.getCast(id: 38) {
			result in
			switch result {
			case .success:
				XCTFail()
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
	}
}
