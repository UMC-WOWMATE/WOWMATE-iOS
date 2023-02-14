//
//  MyPage.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/14.
//

import Foundation

// MARK: - MyPageDataModel
struct MyPageDataModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data1: User
}

// MARK: - User
struct User: Codable {
    var email, univ, phoneNumber, birth, gender, create_date: String
    //, image_url: String
// Data Form    create_date : "2023-02-13 03:19:01.756350"
}
