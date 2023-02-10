//
//  ChatAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

enum ChatAPI {
    case chats
    case chatRoom(String)
}

extension ChatAPI: TargetType {
    
    // 서버의 base URL
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    
    // 서버의 base URL 뒤에 추가 될 Path (API)
    var path: String {
        switch self {
        case .chats:
            return "/chats"
        case .chatRoom(let roomUuid):
            return "/chats/\(roomUuid)"
        }
    }
    
    // HTTP Method
    var method: Moya.Method {
        switch self {
        case .chats:
            return .get
        case .chatRoom(_):
            return .get
        }
    }
    
    // 요청에 사용되는 파라미터 설정
    var task: Moya.Task {
        switch self {
        case .chats:
            return .requestPlain
        case .chatRoom(_):
            return .requestPlain
        }
    }
    
    // HTTP headers
    var headers: [String : String]? {
        switch self {
        case .chats,
                .chatRoom(_):
            return nil // 토큰이 들어가는 헤더 추가 예정
        }
    }
    
}
