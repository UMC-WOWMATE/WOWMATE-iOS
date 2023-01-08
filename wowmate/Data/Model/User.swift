//
//  User.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import Foundation

/// 모델 예시. 개발상황에 따라 변경될 수 있습니다.
class User: Codable {
    var schoolEmail: String
    var id: String
    var password: String
    
    init(schoolEmail: String, id: String, password: String) {
        
        self.schoolEmail = schoolEmail
        self.id = id
        self.password = password
    }
}

