//
//  Chats.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
// MARK: - ChatList
struct ChatList: Codable {
    let chatroomList: [Chatroom]
    let isSuccess: Bool
    let message: String
    let code: Int
}

// MARK: - ChatroomList
struct Chatroom: Codable {
    let opponentImg, postTitle, lastMessage, lastMessageTime: String
}

