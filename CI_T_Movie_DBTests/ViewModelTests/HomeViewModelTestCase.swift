//
//  HomeViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Ramon Queiroz dos Santos on 30/08/22.
//

import XCTest
import Combine
@testable import CI_T_Movie_DB

class HomeViewModelTestCase: XCTestCase {
	var viewModel: HomeViewModel?
	let mockMovie = MovieRepositoryMock()
	let mockGenre = GenreRepositoryMock()
	var repository: MovieRepository?
	let apiMock = APIManagerServiceMock()
	var cancellables: Set<AnyCancellable> = []
	
	let movie = MovieResponse(page: 1, results: [MovieResults(backdropPath: "", genreIDS: [1], id: 1, originalTitle: "The Matrix", overview: "Choose your pill", posterPath: "", releaseDate: "1998-05-20", title: "The Matrix", voteAverage: 9.958)], totalPages: 1, totalResults: 1)
	let genre = GenreList(genres: [Genre(id: 1, name: "Documentary")])
	
	 override func setUp() async throws {
		 viewModel = HomeViewModel(repository: mockMovie, genreRepository: mockGenre)
	 }
	
	func test_successNowPlaying(){
		//given
		mockMovie.movieModel = movie

		// then
		if let viewModel = viewModel {
			viewModel.movieSubject.sink(
				receiveCompletion: {_ in},
				receiveValue: {result in
					XCTAssertEqual(result.results.first?.title, "The Matrix")
				}).store(in: &cancellables)

			//		//when
					viewModel.fetchNowMovie()
		}
	}
	
	func test_sucessUpcomming(){
		//given
		mockMovie.movieModel = movie
	
		// then
		if let viewModel = viewModel {
			viewModel.movieSubject.sink(
				receiveCompletion: {_ in},
				receiveValue: {result in
					XCTAssertEqual(result.results.first?.overview, "Choose your pill")
				}).store(in: &cancellables)
			
			//		//when
					viewModel.fetchUpcommingMovie()
//			viewModel.fetchNowMovie()
		}
	}
	func test_sucessGenre(){
		//given
		mockGenre.genreModel = genre
		// then
		if let viewModel = viewModel {
			viewModel.genreSubject.sink(
				receiveCompletion: {_ in},
				receiveValue: {result in
					XCTAssertEqual(result.genres.count, 1)
				}).store(in: &cancellables)
			
			//		//when
			viewModel.fetchGenre()
		}
	}
	func testMovieRepositoryNowPlaying(){
		mockMovie.error = NSError(domain: "", code: 404)
		apiMock.fetchItemsHandler = { _ , _ in
		}
		mockMovie.getNowPlayingMovie() {
			result in
			switch result {
			case .success:
				XCTFail()
			case .failure(let error):
				XCTAssertNotNil(error)
			}
		}
	}
	func testMovieRepositoryUpcomming(){
		mockMovie.error = NSError(domain: "", code: 404)
		apiMock.fetchItemsHandler = { _ , _ in
		}
		mockMovie.getUpcommingMovie() {
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
