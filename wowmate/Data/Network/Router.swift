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
    case login(user: Login), signup(user: Signup), matchlist, withdraw
    
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
    
    var header: HTTPHeaders {
        switch self {
        case .login:
            return [:]
        case .signup:
            return [:]
        default:
            return [:]
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let user):
            return [
             "email": user.email,
             "password": user.password
            ]
        case .signup(let user):
            return [
                "email": user.email,
                "password": user.password,
                "name": user.name,
                "birth": user.birth,
                "gender": user.gender,
                "phoneNumber": user.phoneNumber,
                "school": user.school
            ]
        case .matchlist:
            return nil
        case .withdraw:
            return nil
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        // Parameters
        if let parameters = parameters {
            return try encoding.encode(request, with: parameters)
        }
        
        return request
    }
}
// 사용법
// AF.request(Router.signup)
