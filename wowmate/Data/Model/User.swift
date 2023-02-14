//
//  User.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import Foundation

/// 회원가입
struct Signup: Codable {
    var phoneNumber: String
    var birth: String
    var gender: String
    var email: String
    var school: String
    var password: String
        
    init() {
        self.phoneNumber = ""
        self.birth = ""
        self.gender = ""
        self.email = ""
        self.school = ""
        self.password = ""
    }
    
//    init(name: String, phoneNumber: String, birth: Date, gender: String, email: String, school: String, password: String) {
//        self.name = name
//        self.phoneNumber = phoneNumber
//        self.birth = birth
//        self.gender = gender
//        self.email = email
//        self.school = school
//        self.password = password
//    }
}

/// 로그인
struct Login: Codable {
    var email: String
    var password: String
}

