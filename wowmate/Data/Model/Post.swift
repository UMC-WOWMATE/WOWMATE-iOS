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
    let data1: [Post]
}

// MARK: - Post
struct Post: Codable {
    let postTitle, categoryName, postTag1, postTag2: String
    let postTag3, postTag4, postTag5: String
    let postLikeNumber: Int
    let schoolName, createdBy: String
}

// MARK: - Post_save
struct Post_save: Codable {
    let postTitle: String
    let categoryName: String
    let postMember: Int
    let tag1, tag2, tag3, tag4, tag5: String?
    let postContext: String
//    let image1, image2, image3, image4, image5: Data
}
