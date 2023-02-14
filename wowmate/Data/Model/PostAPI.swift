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
    case postList
    case postRegister(param: PostRegister)
    case post(postID: Int)
    case postListByCategory(category: String)
    
    case commentRegister(postID: Int, commentContext: CommentRegister)
    //구조체로 해야 깔끔하게 나올듯. 스트링 하나긴 하지만
    
    case postRegisterImage(post: PostRegister, images: [UIImage])
    
}

extension PostAPI: TargetType {
    var baseURL: URL {
        switch self {
//        case .postList:
////            return URL(string: "https://63ba608856043ab3c79a44ce.mockapi.io/api/v1")!
//            return URL(string: "https://hs-archive.shop")!
        default:
            return URL(string: ServiceAPI.baseURL)!
        }
        
    }
    var path: String {
        switch self {
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
        case .postList, .post, .postListByCategory:
            return .get
        case .postRegister, .postRegisterImage, .commentRegister:
            return .post
//        case .mockPosts:
//            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .postList, .post:
            return .requestPlain
        case .postListByCategory(let name):
            let param: [String: String] = [
                "name": name
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .postRegister(let param):
            return .requestJSONEncodable(param)
        //이미지 포함 게시글 등록
        case .postRegisterImage(post: let Post, images: let Images):
//            let data = Post.toJSON()
            
            let jsonData = try! JSONEncoder().encode(Post)
            let PostformData = MultipartFormData(provider: .data(jsonData), name: "postData")
            
            var ImageformData: [MultipartFormData] = []
            for image in Images {
                let imageData = image.pngData()
                ImageformData.append(MultipartFormData(provider: .data(imageData!),
                                                       name: "image\(Images.firstIndex(of: image)!)"))
            }
            
            var multipartData: [MultipartFormData] = []
            multipartData.append(PostformData)
            multipartData.append(contentsOf: ImageformData)
            print(multipartData)
            return .uploadCompositeMultipart(multipartData, urlParameters: [:])
        //이미지 포함 게시글 등록
        case .commentRegister(_, let comment):
            return .requestJSONEncodable(comment)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJneXVuMTcxMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjc2MzQ5MTUwLCJleHAiOjE2Nzg5NDExNTB9.DrZHeL-AqCKMYJlAAe6NqEyVPefbatHJ7RZX4VeFMF8"]
//              return ["Content-Type": "application/json"]
        }
    }
    
}
