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

    case search(keyword: String)

    case postRegister(param: PostRegister)

}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {

        case .posts, .search:
            return URL(string: ServiceAPI.baseURL)!

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
//        case .search(let keyword):
//            return "/posts/search?title=\(keyword)"
        case .search:
            return "/posts/search"
        }
    }
    var method: Moya.Method {
        switch self {
        case .posts, .search:
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
            
//        case .search:
//            return .requestPlain
        case .search(let keyword):
            let param: [String: String] = [
                "title": keyword
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    

    var headers: [String : String]? {
        switch self {

            default:
//            return ["Content-Type":"application/json",
//                    "Authorization": UserDefaults.standard.value(forKey: "token") as! String ]
            return ["Content-Type":"application/json",
                    "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJyeXIwMTIxQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NzYzNTc1MDMsImV4cCI6MTY3ODk0OTUwM30.t6FO6EolUhv4tJkyUreFYOdpBMrfuVkSJJO_2O7ugzU"]
        }
        
    }  
}
