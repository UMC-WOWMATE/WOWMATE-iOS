//
//  Post.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/25.
//

import Foundation

/* 게시글 전체 조회 (get - posts) */
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

/* 게시글 등록 (post - posts) */
// MARK: - PostRegister
struct PostRegister: Codable {
    let postTitle, categoryName: String
    let postMember: Int
    let tag1, tag2, tag3, tag4, tag5, postContext: String
}
