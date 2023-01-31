//
//  ChatAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import MOya

enum ChatAPI {
    case chats
}

extension ChatAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    var path: String {
        switch self {
        case .chats:
            return "/chats"
        }
    }
    var method: Moya.Method {
        switch self {
        case .chats:
            return .get
        }
    }
    var task: Moya.Task {
        switch self {
        case .chats:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .chats:
            return nil // 토큰이 들어가는 헤더 추가 예정
        }
    }
}
