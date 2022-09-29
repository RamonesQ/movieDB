//
//  PhotoViewModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 09/08/22.
//

import Foundation
import Combine

class PhotoViewModel {
    
    private let photosRepository: PhotosRepositoryProtocol
    var photosSubject = PassthroughSubject<MovieImages, Error>()
    
    init(photosRepository: PhotosRepositoryProtocol = PhotosRepository()) {
        self.photosRepository = photosRepository
    }
    
    func fetchPhotos(id: Int){
		 photosRepository.getPhotos(id: id) { [weak self] result in
            switch result {
            case . success(let data):
                self?.photosSubject.send(data)
            case . failure(let error):
                self?.photosSubject.send(completion: .failure(error))
            }
        }
    }
}
