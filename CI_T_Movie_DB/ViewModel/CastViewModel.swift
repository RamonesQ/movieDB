//
//  CastViewModel.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 09/08/22.
//

import Foundation
import Combine

class CastViewModel {
    
   private let castRepository: CastRepositoryProtocol
    var castSubject = PassthroughSubject<CastData, Error>()
    
    init(castRepository: CastRepositoryProtocol = CastRepository()) {
        self.castRepository = castRepository
    }
    
    func fetchCast(id: Int){
        castRepository.getCast(id: id) { [weak self] result in
            switch result {
            case . success(let data):
                self?.castSubject.send(data)
            case . failure(let error):
                self?.castSubject.send(completion: .failure(error))
            }
        }
    }
}
