//
//  ChatManager.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/10.
//

import Foundation
import Moya


class ChatManager {
    private init() {}
    static let shared = ChatManager()
    let provider = MoyaProvider<ChatAPI>()
    
    // Chat API
    
    // 채팅방 존재 여부
    func isExist(_ postId:String, completion: @escaping (Result<ChatRoomExistDataModel, Error>) -> Void ) {
        provider.request(.chatRoomIsExist(postId)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ChatRoomExistDataModel.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // 채팅방 차단 여부
    func isBlock(_ postId:String, completion: @escaping (Result<ChatRoomVerificationDataModel, Error>) -> Void ) {
        provider.request(.chatRoomIsExist(postId)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ChatRoomVerificationDataModel.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // 채팅방 생성
    func createChatRoom(chatRoomData: CreateRoomDataModel, completion: @escaping (Result<String, Error>) -> Void ) {
        provider.request(.createRoom(param: chatRoomData)) { result in
            switch result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data.data, options: []) as? [String : Any] {
                    if let message = json["message"] as? String {
                        completion(.success(message))
                    }
                }
            case .failure(let Error):
                completion(.failure(Error))
            }
        }
    }
    
    
    // 채팅방 리스트 조회
    func getChatRoomList(completion: @escaping (Result<ChatRoomListDataModel, Error>) -> Void ) {
        provider.request(.chatList) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ChatRoomListDataModel.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // 특정 채팅방 조회
    func getChatRoom(_ roomUuid:String, completion: @escaping (Result<ChatRoomDataModel, Error>) -> Void ) {
        provider.request(.chatRoom(roomUuid)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ChatRoomDataModel.self, from: data.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
}
