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
    case postRegister(param: PostRegister)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .mockPosts:
            return URL(string: "https://63ba608856043ab3c79a44ce.mockapi.io/api/v1")!
        default:
            return URL(string: ServiceAPI.baseURL)!
        }
        
    }
    var path: String {
        switch self {
        case .posts, .postRegister:
            return "/posts"
        case .mockPosts:
            return "/posts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .posts:
            return .get
        case .postRegister:
            return .post
        case .mockPosts:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .posts:
            return .requestPlain
        case .postRegister(let param):
            return .requestJSONEncodable(param)
        case .mockPosts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
