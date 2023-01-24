//
//  Post.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/25.
//

import Foundation

struct Post: Codable {
    var postTitle: String
    var categoryName: String
    var postTags: [String]
    var postCreatedDate: Date // LocalDateTime?
    var postLikeNumber: Int
    var schoolId: String
}
