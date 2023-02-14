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
    case mockPosts

    case search(keyword: String)

    case postRegister(param: PostRegister)


    case postList
//    case postRegister(param: PostRegister)
    case post(postID: Int)
    case postListByCategory(category: String)
    
    case commentRegister(postID: Int, commentContext: CommentRegister)
    //구조체로 해야 깔끔하게 나올듯. 스트링 하나긴 하지만
    
    case postRegisterImage(post: PostRegister, images: [UIImage])
    

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

//        case .postList:
////            return URL(string: "https://63ba608856043ab3c79a44ce.mockapi.io/api/v1")!
//            return URL(string: "https://hs-archive.shop")!


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

        case .postList, .postRegister, .postRegisterImage:
            return "/posts"
        case .post(let postID):
            return "/posts/\(postID)"
        case .postListByCategory:
            return "/posts/category"
        case .commentRegister(let postID, _):
            return "/posts/\(postID)/comments"

        }
    }
    var method: Moya.Method {
        switch self {

        case .posts, .search:
            return .get
        case .postRegister:
            return .post
  
        case .postList, .post, .postListByCategory:
            return .get
        case .postRegister, .postRegisterImage, .commentRegister:
            return .post
        default:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .postList, .post:
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

        case .postListByCategory(let name):
            let param: [String: String] = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .postRegister(let param):
            return .requestJSONEncodable(param)
            
      case .postRegisterImage(post: let Post, images: let Images):
            var formData: [MultipartFormData] = []
//            var data = MultipartFormData(provider: .data(Post.postTitle.data(using: .utf8)!), name: "postTitle")
            

            formData.append(MultipartFormData(provider: .data(Post.postTitle.data(using: .utf8)!), name: "postTitle"))
            formData.append(MultipartFormData(provider: .data(Post.categoryName.data(using: .utf8)!), name: "categoryName"))
            formData.append(MultipartFormData(provider: .data(String(Post.postMember).data(using: .utf8)!), name: "postMember"))
            formData.append(MultipartFormData(provider: .data(Post.tag1.data(using: .utf8)!), name: "tag1"))
            formData.append(MultipartFormData(provider: .data(Post.tag2.data(using: .utf8)!), name: "tag2"))
            formData.append(MultipartFormData(provider: .data(Post.tag3.data(using: .utf8)!), name: "tag3"))
            formData.append(MultipartFormData(provider: .data(Post.tag4.data(using: .utf8)!), name: "tag4"))
            formData.append(MultipartFormData(provider: .data(Post.tag5.data(using: .utf8)!), name: "tag5"))
            formData.append(MultipartFormData(provider: .data(Post.postContext.data(using: .utf8)!), name: "postContext"))
            
//            var multipartFile: [MultipartFormData] = []
            
            for image in Images {
                let imageData = image.pngData()
                formData.append(MultipartFormData(provider: .data(imageData!),
                                                  name: "image\(Images.firstIndex(of: image)!)"))
            }
            
//            formData.append(contentsOf: multipartFile)
            
            return .uploadMultipart(formData)
            
        //이미지 포함 게시글 등록
        case .commentRegister(_, let comment):
            return .requestJSONEncodable(comment)
            
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
