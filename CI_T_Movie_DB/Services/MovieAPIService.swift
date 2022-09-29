//
//  MovieAPIService.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 26/08/22.
//

import Foundation

class MovieAPIService {
    
    private static let baseUrl = "https://api.themoviedb.org/3/"
    public let imageUrl = "https://image.tmdb.org/t/p/"
    private static let apiKey = "70ced31342a22ffb69b95c7a60feb944"
    private static let movieEndpoint = "movie/"
    private static let genreEndpoint = "genre/movie/"
    public let lowImageEndpopint = "w200"
    public let regularImageEndpoint = "w500"
    
    static func getCastURLString(id: Int) -> URL? {
        let urlComponents = URLComponents(string: "\(baseUrl)\(movieEndpoint)\(id)/credits?api_key=\(apiKey)")
        return urlComponents?.url
    }
    static func getPhotosURLString(id: Int) -> URL? {
        let urlComponents = URLComponents(string: "\(baseUrl)\(movieEndpoint)\(id)/images?api_key=\(apiKey)")
        return urlComponents?.url
    }
    static func getGenreURLString() -> URL? {
        let urlComponents = URLComponents(string: "\(baseUrl)\(genreEndpoint)list?api_key=\(apiKey)")

        return urlComponents?.url
    }
    static func getNowPlayingMovieURLString() -> URL?{
        let urlComponents = URLComponents(string: "\(baseUrl)\(movieEndpoint)now_playing?api_key=\(apiKey)")
        return urlComponents?.url
    }
    static func getUpcommingMovieURLString() -> URL?{
        let urlComponents = URLComponents(string: "\(baseUrl)\(movieEndpoint)upcoming?api_key=\(apiKey)")
        return urlComponents?.url
    }
    static func getMovieDetailsURLString(id: Int) -> URL?{
        let urlComponents = URLComponents(string: "\(baseUrl)\(movieEndpoint)\(id)?api_key=\(apiKey)")
        return urlComponents?.url
    }
}
