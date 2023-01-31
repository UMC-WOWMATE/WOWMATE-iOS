//
//  AuthAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

enum AuthAPI {
    case signup(user: Signup)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    var path: String {
        switch self {
        case .signup:
            return "/sign-api/sign-up"
        }
    }
    var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .signup(let user):
            let params: [String: Any] = [
                "email": user.email,
                "password": user.password,
                "univ": user.school,
                "phoneNumber": user.phoneNumber,
                "birth": user.birth,
                "gender": user.gender,
                "role": "USER" // 정체 불명
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        default:
            let params: [String: Any] = []
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        }
    }
    var headers: [String : String]? {
        switch self {
        case .signup(_):
            return ["Content-type": "application/json"]
        }
        
    }
}

