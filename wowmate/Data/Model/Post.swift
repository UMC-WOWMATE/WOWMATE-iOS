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
    let data2: [Comment]
}

struct PostData1: Codable {
    let postId: Int
    let postTitle, categoryName, tag1, tag2: String
//    let tag3, tag4, tag5: String
    let postLikeNumber: Int
    let postMember: String
    let schoolName, createdDate: String
}

struct PostData2: Codable {
//    let isPostUser: Bool
//    let postId: Int
    let postTitle, categoryName, postTag1, postTag2: String
//    let postTag3, postTag4, postTag5: String
    let postLikeNumber: Int
//    let postMember: String
    let postContext: String
    let createdDate: String
}

struct Comment: Codable {
    let commentId: Int
    let commentContext: String
    let likeNumber: Int
    let createdDate: String
    let commentReplyDtoList: [CommentReply]
}

struct CommentReply: Codable {
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
    
//    func toJSON() -> [String: Any] {
//        return ["postTitle" : postTitle,
//                "categoryName" : categoryName,
//                "postMember" : postMember,
//                "tag1" : tag1, "tag2" : tag2, "tag3" : tag3, "tag4" : tag4, "tag5" : tag5,
//                "postContext" : postContext]
//    }
}

struct CommentRegister: Codable {
    let commentContext: String
}
