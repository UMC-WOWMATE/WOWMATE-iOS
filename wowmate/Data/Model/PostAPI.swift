//
//  PostAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation

enum PostAPI {
    case posts
}

extension PostAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .posts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }  
}
