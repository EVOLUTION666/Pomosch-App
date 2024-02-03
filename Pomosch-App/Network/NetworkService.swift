//
//  NetworkService.swift
//  Pomosch-App
//
//  Created by Andrey on 21.01.2024.
//

import Foundation
import Apollo
import PomoschAPI

final class NetworkService {
    static let shared = NetworkService()
    
    private(set) var apollo = ApolloClient(url: URL(string: "https://api.pomosch.app/graphql")!)
    
    private init() {}
}

extension NetworkService {
    func fetchWards(completion: @escaping (Result<WardsQuery.Data, Error>) -> Void) {
        let query = WardsQuery()
        NetworkService.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let value):
                completion(.success(value.data!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
