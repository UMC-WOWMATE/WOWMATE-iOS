//
//  PostAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya
import UIKit

enum PostAPI {

    case posts

    case search(keyword: String)

    case postList
    case post(postID: Int)
    case postListByCategory(category: String)
    
    case commentRegister(postID: Int, commentContext: CommentRegister)
    //구조체로 해야 깔끔하게 나올듯. 스트링 하나긴 하지만
    
    case postRegisterImage(post: PostRegister, images: [UIImage])
    case postAccusation(postID: Int, reason: String)
}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {

        case .posts, .search:
            return URL(string: ServiceAPI.baseURL)!

        default:
            return URL(string: ServiceAPI.baseURL)!


        }
        
    }
    var path: String {
        switch self {

        case .posts:
            return "/posts"
//        case .search(let keyword):
//            return "/posts/search?title=\(keyword)"
        case .search:
            return "/posts/search"

        case .postList, .postRegisterImage:
            return "/posts"
        case .post(let postID):
            return "/posts/\(postID)"
        case .postListByCategory:
            return "/posts/category"
        case .commentRegister(let postID, _):
            return "/posts/\(postID)/comments"
        case .postAccusation(let postID, _):
            return "/postAccusation/\(postID)"
        }
    }
    var method: Moya.Method {
        switch self {

        case .posts, .search:
            return .get
  
        case .postList, .post, .postListByCategory:
            return .get
        case .postRegisterImage, .commentRegister, .postAccusation:
            return .post
        default:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .postList, .post:
            return .requestPlain
            
//        case .search:
//            return .requestPlain
        case .search(let keyword):
            let param: [String: String] = [
                "title": keyword
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)

        case .postListByCategory(let name):
            let param: [String: String] = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
      case .postRegisterImage(post: let Post, images: let Images):
            var formData: [MultipartFormData] = []

            formData.append(MultipartFormData(provider: .data(Post.postTitle.data(using: .utf8)!), name: "postTitle"))
            formData.append(MultipartFormData(provider: .data(Post.categoryName.data(using: .utf8)!), name: "categoryName"))
            formData.append(MultipartFormData(provider: .data(String(Post.postMember).data(using: .utf8)!), name: "postMember"))
            formData.append(MultipartFormData(provider: .data(Post.tag1.data(using: .utf8)!), name: "tag1"))
            formData.append(MultipartFormData(provider: .data(Post.tag2.data(using: .utf8)!), name: "tag2"))
            formData.append(MultipartFormData(provider: .data(Post.tag3.data(using: .utf8)!), name: "tag3"))
            formData.append(MultipartFormData(provider: .data(Post.tag4.data(using: .utf8)!), name: "tag4"))
            formData.append(MultipartFormData(provider: .data(Post.tag5.data(using: .utf8)!), name: "tag5"))
            formData.append(MultipartFormData(provider: .data(Post.postContext.data(using: .utf8)!), name: "postContext"))
            
            for image in Images {
                let imageData = image.jpegData(compressionQuality: 0.8)
//                let imageData = image.pngData()
                formData.append(MultipartFormData(provider: .data(imageData!),
                                                  name: "image\(Images.firstIndex(of: image)!+1)", fileName: "image\(Images.firstIndex(of: image)!+1).jpg"))
            }
            
            print(formData)
            return .uploadMultipart(formData)
            
        case .commentRegister(_, let comment):
            return .requestJSONEncodable(comment)
            
        case .postAccusation(_, let reason):
            let param: [String: String] = [
                "reason": reason
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    

    var headers: [String : String]? {
        switch self {

        case .postRegisterImage:
            return ["Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJneXVuMTcxMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjc2MzgyNjI4LCJleHAiOjE2Nzg5NzQ2Mjh9.nnGqTXvUlxXgZuulIIJsmKVK7MIk1VHzFQfBGjItI0Q"]
            default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJneXVuMTcxMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjc2MzgyNjI4LCJleHAiOjE2Nzg5NzQ2Mjh9.nnGqTXvUlxXgZuulIIJsmKVK7MIk1VHzFQfBGjItI0Q"]
//              return ["Content-Type": "application/json"]
        }
    }
    

}
