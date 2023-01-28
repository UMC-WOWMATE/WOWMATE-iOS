//
//  AuthManager.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import Foundation
import Alamofire

/// 로그인, 회원가입 인증 매니저
/// 개발 상황에 따라 코드 변경 예정
class AuthManager {
    private init() {}
    
    static let shared = AuthManager()
    
    
    func login(id: String, password: String) {
        AF.request(Router.signup as! URLRequestConvertible).response { response in
            switch response.result {
                
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
