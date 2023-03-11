//
//  ChatAPI.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
import Moya

enum ChatAPI {
    case chatList
    case chatRoom(String)
    case createRoom(param: CreateRoomDataModel)
}

extension ChatAPI: TargetType {
    
    // 서버의 base URL
    var baseURL: URL {
        return URL(string: ServiceAPI.baseURL)!
    }
    
    // 서버의 base URL 뒤에 추가 될 Path (API)
    var path: String {
        switch self {
        case .createRoom(_):
            return "/chat/create"
        case .chatList:
            return "/chats"
        case .chatRoom(let roomUuid):
            return "/chats/\(roomUuid)"
        }
    }
    
    // HTTP Method
    var method: Moya.Method {
        switch self {
        case .createRoom(_):
            return .post
        case .chatList:
            return .get
        case .chatRoom(_):
            return .get
        }
    }
    
    // 요청에 사용되는 파라미터 설정
    var task: Moya.Task {
        switch self {
        case .createRoom(let param):
            return .requestJSONEncodable(param)
        case .chatList:
            return .requestPlain
        case .chatRoom(_):
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
