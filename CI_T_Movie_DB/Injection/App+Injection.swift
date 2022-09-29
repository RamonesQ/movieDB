//
//  App+Injection.swift
//  CI&T Movie Database
//
//  Created by Ramon Queiroz dos Santos on 26/08/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        register { APIManager() as APIManagerService }
        register { MovieAPIService() as MovieAPIService}
        
        // MARK: - Repositories
        register { MovieRepository (apiManager: resolve()) as MovieRepositoryProtocol }
        
        // MARK: - ViewModels
        register { CastViewModel() }
        register { PhotoViewModel() }
        register { DetailsViewModel() }
        register { HomeViewModel() }
    }
}
