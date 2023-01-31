//
//  PostAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

enum PostAPI {
    case posts
    case mockPosts
}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .posts:
            return URL(string: ServiceAPI.baseURL)!
        case .mockPosts:
            return URL(string: "https://63ba608856043ab3c79a44ce.mockapi.io/api/v1")!
        }
        
    }
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .mockPosts:
            return "/posts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        case .mockPosts:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .posts:
            return .requestPlain
        case .mockPosts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }  
}
