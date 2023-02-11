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
    let data1: [PostData1]
}

// MARK: - Post
struct Post: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: PostData2
    let data2: [Coment]
}

struct PostData1: Codable {
    let postTitle, categoryName, tag1, tag2: String
//    let tag3, tag4, tag5: String
    let postLikeNumber: Int
//    let postMember: Int
    let schoolName, createdDate: String
}

struct PostData2: Codable {
    let postTitle, categoryName, postTag1, postTag2: String
//    let tag3, tag4, tag5: String
    let postLikeNumber: Int
//    let postMember: Int
//    let schoolName
    let createdDate: String
}

struct Coment: Codable {
    let commentContext: String
    let likeNumber: Int
    let createdDate: String
    let commentReplyDtoList: [commentReply]
}

struct commentReply: Codable {
    let commentReplyContext: String
    let likeNumber: Int
    let createdDate: String
}

/* 게시글 등록 (post - posts) */
// MARK: - PostRegister
struct PostRegister: Codable {
    let postTitle, categoryName: String
    let postMember: Int
    let tag1, tag2, tag3, tag4, tag5, postContext: String
}
