//
//  PostManager.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya
import UIKit

class PostManager {
    private init() {}
    static let shared = PostManager()
    let provider = MoyaProvider<PostAPI>()
    

    func registerPost_Image(post: PostRegister, images: [UIImage] , completion: @escaping (Result<String, Error>) -> Void ) {
        print("registerPost_Image called")
        provider.request(.postRegisterImage(post: post, images: images)) { result in
            print(result)
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
                        completion(.success(message))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func registerComment(ID: Int, comment: CommentRegister, completion: @escaping (Result<String, Error>) -> Void ) {
        provider.request(.commentRegister(postID: ID, commentContext: comment)) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
                        completion(.success(message))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPostList(completion: @escaping (Result<PostList, Error>) -> Void ) {
        provider.request(.postList) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PostList.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPost(ID: Int, completion: @escaping (Result<Post, Error>) -> Void ) {
        provider.request(.post(postID: ID)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Post.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getPostListByCategory(Category: String, completion: @escaping (Result<PostList, Error>) -> Void ) {
        provider.request(.postListByCategory(category: Category)) { result in

            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()

                    let result = try decoder.decode(PostList.self, from: data.data)

                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func accusationPost(ID: Int, reason: PostDeclare, completion: @escaping (Result<String, Error>) -> Void ) {
        provider.request(.postAccusation(postID: ID, reason: reason)) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
                        completion(.success(message))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


/**
 PostManager 사용예제
 - ViewController의 ViewDidLoad나 데이터를 갱신해야하는 시점에서 아래 코드와 같은 형태로 사용
 
 PostManager.shared.getMockPosts { result in
     switch result {
     case .success(let success):
         print(success, "성공") //  데이터 불러오는 것이 성공했을 때
     case .failure(let failure):
         print(failure) // 여러가지 이유로 통신이 실패했을 때 
     }
 }
 */

