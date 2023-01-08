//
//  Router.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import Foundation
import Alamofire

// URL Router 예시. 추후 개발상황에 따라 변경예정
enum Router: URLRequestConvertible {
    case login, signup, matchlist, withdraw
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        case .signup: return .post
        case .matchlist: return .get
        case .withdraw: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .login: return "auth/login"
        case .signup: return "auth/signup"
        case .matchlist: return "home"
        case .withdraw: return "auth/withdraw"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
// 사용법
// AF.request(Router.signup)
