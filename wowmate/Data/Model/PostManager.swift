//
//  PostManager.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

class PostManager {
    private init() {}
    static let shared = PostManager()
    let provider = MoyaProvider<PostAPI>()
    
    // Mock API 용 Post 정보
    func getMockPosts(completion: @escaping (Result<[Post], Error>) -> Void ) {
        provider.request(.mockPosts) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([Post].self, from: data.data)
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


/**
 PostManager 사용예제
 - ViewController의 ViewDidLoad나 데이터를 갱신해야하는 시점에서 아래 코드와 같은 형태로 사용
 
 PostManager.shared.getMockPosts { result in
     switch result {
     case .success(let success):
         print(success, "성공") //  데이터 불러오는 것이 성공했을 때
     case .failure(let failure):
         print(failure) // 여러가지 이유로 통신이 실패했을 때 
     }
 }
 */
