//
//  Chats.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
// MARK: - ChatRoomListDataModel
struct ChatRoomListDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: [Data1]
}

struct Data1: Codable {
    let roomUuID, postTitle, lastMessage, lastMessageDate: String
    let opponentUserImg: String
}

// MARK: - ChatRoomDataModel
struct ChatRoomDataModel {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: Data2
}

struct Data2 {
    let postTitle, postCategory, createdDate, opponentImg, opponentEmail, userEmail: String
    let messageList: [MessageList]
}

struct MessageList {
    let content, senderEmail, sendDate: String
}
