//
//  PostAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

enum PostAPI {
    case postList
    case post
//    case mockPosts
    case postRegister(param: PostRegister)
    case post1(postID: Int)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .postList:
//            return URL(string: "https://63ba608856043ab3c79a44ce.mockapi.io/api/v1")!
            return URL(string: "https://hs-archive.shop")!
        default:
//            return URL(string: ServiceAPI.baseURL)!
            return URL(string: "https://hs-archive.shop")!
        }
        
    }
    var path: String {
        switch self {
        case .postList, .postRegister:
            return "/posts"
//        case .mockPosts:
//            return "/posts"
        case .post:
            return "/posts/24"
        case .post1(let postID):
            return "/post/\(postID)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .postList, .post:
            return .get
        case .postRegister:
            return .post
        case .post1:
            return .get
//        case .mockPosts:
//            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .postList, .post:
            return .requestPlain
        case .postRegister(let param):
            return .requestJSONEncodable(param)
        case .post1:
            return .requestPlain
//        case .mockPosts:
//            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
            default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJneXVuMTcxMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjc2MTEwNzQ2LCJleHAiOjE2NzYxMTQzNDZ9.dbtwrRl1TRdBKqeHF5D7QWfmnIa4a4sN1cZKYCr_GTI"]
//              return ["Content-Type": "application/json"]
        }
    }
    
}
