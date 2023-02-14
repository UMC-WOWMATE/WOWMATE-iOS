//
//  SearchManager.swift
//  wowmate
//
//  Created by 김초원 on 2023/02/12.
//

import Foundation
import Moya

class SearchManager {
    private init() {}
    static let shared = SearchManager()
    let provider = MoyaProvider<PostAPI>()
    
    func searchPostRequest(keyword: String, completion: @escaping (Result<PostList, Error>) -> Void ) {
        provider.request(.search(keyword: keyword)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PostList.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
