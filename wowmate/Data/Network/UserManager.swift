//
//  UserManager.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/14.
//

import Foundation
import Moya


class UserManager {
    private init() {}
    static let shared = UserManager()
    let provider = MoyaProvider<UserAPI>()
  
    // 채팅방 리스트 조회
    func getUserInfo(completion: @escaping (Result<MyPageDataModel, Error>) -> Void ) {
        provider.request(.mypage) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MyPageDataModel.self, from: data.data)
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
