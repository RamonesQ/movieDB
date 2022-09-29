//
//  HomeViewModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 09/08/22.
//

import Foundation
import Combine

class HomeViewModel {
    
    private let movieRepository: MovieRepositoryProtocol
	private let genreRepository: GenreRepositoryProtocol
    var genreSubject = PassthroughSubject<GenreList, Error>()
    var movieSubject = PassthroughSubject<MovieResponse, Error>()
    var movieCommingSubject = PassthroughSubject<MovieResponse, Error>()
    
	init(repository: MovieRepositoryProtocol = MovieRepository(), genreRepository: GenreRepositoryProtocol = GenreRepository()) {
        self.movieRepository = repository
		self.genreRepository = genreRepository
    }
    
    func fetchGenre(){
		 genreRepository.getGenre() { [weak self] result in
            switch result {
            case . success(let data):
                self?.genreSubject.send(data)
            case . failure(let error):
                self?.genreSubject.send(completion: .failure(error))
            }
        }
    }
    
    func fetchUpcommingMovie(){
        movieRepository.getUpcommingMovie(){ [weak self] result in
            switch result {
            case . success(let data):
                self?.movieCommingSubject.send(data)
            case . failure(let error):
                self?.movieCommingSubject.send(completion: .failure(error))
            }
        }
    }
    
    func fetchNowMovie(){
        movieRepository.getNowPlayingMovie(){ [weak self] result in
            switch result {
            case . success(let data):
                self?.movieSubject.send(data)
            case . failure(let error):
                self?.movieSubject.send(completion: .failure(error))
            }
        }
    }
}

