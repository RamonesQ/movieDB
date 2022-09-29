//
//  DetailsViewModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 09/08/22.
//

import Foundation
import Combine

class DetailsViewModel {
    
    private let detailsRepository: DetailsRepositoryProtocol
	private let photosRepository: PhotosRepositoryProtocol
    var detailsSubject = PassthroughSubject<DetailsObject, Error>()
    var photosSubject = PassthroughSubject<MovieImages, Error>()
    
    init(detailsRepository: DetailsRepositoryProtocol = DetailsRepository(), photosRepository: PhotosRepositoryProtocol = PhotosRepository()) {
        self.detailsRepository = detailsRepository
		 self.photosRepository = photosRepository
    }
    
    func fetchMovieDetails(id: Int){
		 detailsRepository.getMovieDetails(id: id) { [weak self] (result: Result<MovieDetails, Error>) in
            switch result{
            case . success(let data):
					let newData = DetailsObject( runtimeFormattedString: (self?.formatRuntime(runtime: data.runtime)), voteAverageFormatted: String(format:"%.1f", data.voteAverage), backdropPath: data.backdropPath, originalTitle: data.originalTitle, overview: data.overview, genresFormatted: (self?.formatGenres(genres: data.genres))!, id: data.id)
                self?.detailsSubject.send(newData)
            case . failure(let error):
                self?.detailsSubject.send(completion: .failure(error))
            }
        }
    }
	private func formatRuntime(runtime: Int) -> String?{
		let runtime = (runtime * 60)
		let runtimeFormatter = DateComponentsFormatter()
		runtimeFormatter.allowedUnits = [.hour, .minute]
		runtimeFormatter.unitsStyle = .abbreviated
		let runtimeFormattedString = runtimeFormatter.string(from: TimeInterval(runtime))
		return runtimeFormattedString
	}
	private func formatGenres(genres: [Genre]) -> String{
		genres.map {$0.name ?? ""}.joined(separator: ", ")
	}
		
    func fetchPhotos(id: Int){
		 photosRepository.getPhotos(id: id){ [weak self] result in
            switch result {
            case . success(let data):
                self?.photosSubject.send(data)
            case . failure(let error):
                self?.photosSubject.send(completion: .failure(error))
            }
        }
    }
}

