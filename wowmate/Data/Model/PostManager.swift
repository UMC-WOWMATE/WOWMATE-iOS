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


// MARK: 네트워크 관련 폴더가 로컬에서 이유모르게,,빨간색으로 뜨고,,파일 추가도 되지 않아서,,우선 임시방편으로 여기다가 끼워서 정의하는,,이후에 수정예정,,
class HomeManager {
    private init() {}
    static let shared = HomeManager()
    let provider = MoyaProvider<AuthAPI>()
    
    func signinRequest(user: Login, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.signin(login: user)) {result in
            switch result {
            case .success(let success):
                if let json = try? JSONSerialization.jsonObject(with: success.data, options: []) as? [String : Any] {
                    if let code = json["code"] as? Int {
                        if code == 200 {
                            // MARK: UserDefaults에 token 저장
                            let token = json["token"] as? String
                            let bearerToken = "Bearer " + token!
                            UserDefaults.standard.set(bearerToken, forKey: "token")
                            print(UserDefaults.standard.value(forKey: "token")!)
                        }
                    }
                    if let message = json["message"] as? String {
                        completion(.success(message))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signupRequest(user: Signup, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.signup(user: user)) {result in
            print("user :: \(user)")
            switch result {
            case .success(let success):
                if let json = try? JSONSerialization.jsonObject(with: success.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
                         completion(.success(message))
                     }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func emailValidationRequest(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.emailConfirm(email: email)) { result in
            switch result {
            case .success(let success):
                if let json = try? JSONSerialization.jsonObject(with: success.data, options: []) as? [String : Any] {
                    if let confirm = json["data1"] as? [String : Any] {
                        let code = confirm["code"] as? String
                        completion(.success(code!))
                     }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


class SearchManager {
    private init() {}
    static let shared = SearchManager()
    let provider = MoyaProvider<AuthAPI>()
    
    func searchPostRequest(keyword: String, completion: @escaping (Result<String, Error>) -> Void) {
//        provider.request
    }
}
