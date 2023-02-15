//
//  HomeManager.swift
//  wowmate
//
//  Created by 김초원 on 2023/02/12.
//

import Foundation
import Moya

class AuthManager {
    private init() {}
    static let shared = AuthManager()
    let provider = MoyaProvider<AuthAPI>()
    
    // Result<String,Error> ---> Result<[String:Any]
    func signinRequest(user: Login, completion: @escaping (Result<[String:Any], Error>) -> Void) {
        provider.request(.signin(login: user)) {result in
            print(result)
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
                    if let response = json["message"] as? String {
                        completion(.success(json))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signupRequest(user: Signup, completion: @escaping (Result<[String:Any], Error>) -> Void) {
        provider.request(.signup(user: user)) {result in
            print("user :: \(user)")
            switch result {
            case .success(let success):
                if let json = try? JSONSerialization.jsonObject(with: success.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
//                         completion(.success(message))
                         completion(.success(json))
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
    
    func changePassword(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.changePassword(email: email, newPassword: password)) { result in
            switch result {
            case .success(let success):
                if let json = try? JSONSerialization.jsonObject(with: success.data, options: []) as? [String : Any] {
                    completion(.success(json["message"] as! String))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
