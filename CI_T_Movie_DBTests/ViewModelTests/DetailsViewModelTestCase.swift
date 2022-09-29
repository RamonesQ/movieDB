//
//  DetailsViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import XCTest
import Combine
@testable import CI_T_Movie_DB

class DetailsViewModelTestCase: XCTestCase {
	var viewModel: DetailsViewModel!
	let detailsMock = DetailsRepositoryMock()
	let photosMock = PhotosRepositoryMock()
	let apiMock = APIManagerServiceMock()
	var repository: DetailsRepository!
	var cancellables: Set<AnyCancellable> = []
	
	override func setUp() async throws {
		viewModel = DetailsViewModel(detailsRepository: detailsMock, photosRepository: photosMock)
	}
	
	let movieDetails = MovieDetails(backdropPath: "", genres: [Genre(id: 4, name: "Animation"), Genre(id: 30, name: "Horror"), Genre(id: 80, name: "Action")], id: 1, originalTitle: "Original", overview: "Novo filme", releaseDate: "2022-10-10", runtime: 127, voteAverage: 8.312)
	let photos = MovieImages(backdrops: [Backdrop(filePath: "")], id: 3)
	
	func test_succesFetchDetails(){
		//given
		detailsMock.detailsModel = movieDetails
		// then
		viewModel.detailsSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertNotNil(result)
			}).store(in: &cancellables)
		//when
		viewModel.fetchMovieDetails(id: 10)
	}
	func test_sucessFormatVote(){
		//given
		detailsMock.detailsModel = movieDetails
		// then
		viewModel.detailsSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.voteAverage, "8.3")
			}).store(in: &cancellables)
		// when
		viewModel.fetchMovieDetails(id: 10)
	}
	func test_sucessFormatGenre(){
		//given
		detailsMock.detailsModel = movieDetails
		// then
		viewModel.detailsSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.genres, "Animation, Horror, Action")
			}).store(in: &cancellables)
		// when
		viewModel.fetchMovieDetails(id: 10)
	}
	func test_sucessFormatRuntime(){
		//given
		detailsMock.detailsModel = movieDetails
		// then
		viewModel.detailsSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.runtime, "2h 7min")
			}).store(in: &cancellables)
		// when
		viewModel.fetchMovieDetails(id: 10)
	}
	func test_successFetchPhotos(){
		//given
		photosMock.photosModel = photos
		// then
		viewModel.photosSubject.sink(
			receiveCompletion: {_ in},
			receiveValue: {result in
				XCTAssertEqual(result.backdrops.count, 1)
			}).store(in: &cancellables)
		//when
		viewModel.fetchPhotos(id: 1)
	}
	func test_ErrorFetchDetails(){
		//given
		detailsMock.error = NSError(domain: "", code: 404)
		// then
		viewModel.detailsSubject.sink(
			receiveCompletion: {result in
				XCTAssertNotNil(result)
			},
			receiveValue: {_ in
				XCTFail("")
			}).store(in: &cancellables)
		//when
		viewModel.fetchMovieDetails(id: 10)
	}
	func testCastRepository(){
		detailsMock.error = NSError(domain: "", code: 404)
		apiMock.fetchItemsHandler = { _ , _ in
		}
		detailsMock.getMovieDetails(id: 10) {
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
