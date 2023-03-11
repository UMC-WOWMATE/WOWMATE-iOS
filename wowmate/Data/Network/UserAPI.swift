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
    case withdraw
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
        case .withdraw:
            return "/secession"
        }
            
    }
    
    // HTTP Method
    var method: Moya.Method {
        switch self {
        case .mypage:
            return .get
        case .withdraw:
            return .get
        }
    }
    
    // 요청에 사용되는 파라미터 설정
    var task: Moya.Task {
        switch self {
        case .mypage:
            return .requestPlain
        case .withdraw:
            return .requestPlain
        }
    }
    
    // HTTP headers
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json",
                                "Authorization": UserDefaults.standard.value(forKey: "token") as! String]
        }
    }
    
}

