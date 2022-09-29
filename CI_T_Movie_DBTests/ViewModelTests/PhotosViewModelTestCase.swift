//
//  PhotosViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import XCTest
import Combine
@testable import CI_T_Movie_DB

class PhotosViewModelTestCase: XCTestCase {
	var viewModel: PhotoViewModel!
	let apiMock = APIManagerServiceMock()
	let mock = PhotosRepositoryMock()
	//var repository: PhotosRepository!
	var cancellables: Set<AnyCancellable> = []
	
	let photos = MovieImages(backdrops: [Backdrop(filePath: "")], id: 1)
	
	override func setUp() async throws {
		viewModel = PhotoViewModel(photosRepository: mock)
	}
	
	func test_success(){
		//given
		mock.photosModel = photos
		// then
		viewModel.photosSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.backdrops.count, 1)
			}).store(in: &cancellables)
		//when
		viewModel.fetchPhotos(id: 1)
	}
	func testPhotosRepository(){
		mock.error = NSError(domain: "", code: 404)
		apiMock.fetchItemsHandler = { _ , _ in
		}
		mock.getPhotos(id: 1) {
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
