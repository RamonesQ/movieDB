//
//  MovieRepository.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 09/08/22.
//

import Foundation

protocol MovieRepositoryProtocol {

    func getNowPlayingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void )
    func getUpcommingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void )
}

class MovieRepository: MovieRepositoryProtocol {
    private let apiManager: APIManagerService
    
    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }
    func getNowPlayingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        guard let url = MovieAPIService.getNowPlayingMovieURLString() else { return }
        
        apiManager.fetchItems(url: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpcommingMovie(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        guard let url = MovieAPIService.getUpcommingMovieURLString() else { return }
        
        apiManager.fetchItems(url: url) { (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
