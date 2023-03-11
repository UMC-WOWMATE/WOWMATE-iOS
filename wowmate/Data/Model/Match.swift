//
//  Match.swift
//  wowmate
//
//  Created by Dongwan Ryoo on 2023/02/14.
//

import Foundation

// MARK: - PostList
struct MatchList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: [Match]?
}

// MARK: - Post
struct Match: Codable {
    let postId: Int
    let postTitle, categoryName, tag1, tag2: String
//    let tag3, tag4, tag5: String
    let postLikeNumber: Int
//    let schoolName, createdBy: String
    let schoolName, createdDate: String
}
