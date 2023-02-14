//
//  UserAPI.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/14.
//

import Foundation
import Moya


enum UserAPI {
    case mypage
}

extension UserAPI: TargetType {
    
    // 서버의 base URL
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    
    // 서버의 base URL 뒤에 추가 될 Path (API)
    var path: String {
        switch self {
        case .mypage:
            return "/mypage"
        }
    }
    
    // HTTP Method
    var method: Moya.Method {
        switch self {
        case .mypage:
            return .get
        }
    }
    
    // 요청에 사용되는 파라미터 설정
    var task: Moya.Task {
        switch self {
        case .mypage:
            return .requestPlain
        }
    }
    
    // HTTP headers
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJneXVuMTcxMkBnbWFpbC5jb20iLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjc2MzU1OTA3LCJleHAiOjE2Nzg5NDc5MDd9.WSvZgtt5qBkaf2XmRT5DnV9gSJeZvC1EopITqlny6VM"]
        }
    }
    
}

