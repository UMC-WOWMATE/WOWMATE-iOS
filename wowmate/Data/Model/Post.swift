//
//  Post.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/25.
//

import Foundation

// MARK: - PostList
struct PostList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: [Post]?
}

// MARK: - Post
struct Post: Codable {
    let postTitle, categoryName, tag1, tag2: String
//    let tag3, tag4, tag5: String
    let postLikeNumber: Int
//    let schoolName, createdBy: String
    let schoolName, createdDate: String
}
