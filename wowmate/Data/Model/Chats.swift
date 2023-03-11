//
//  Chats.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/31.
//

import Foundation
// MARK: - ChatRoomListDataModel
struct ChatRoomListDataModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data1: [data1]
}

struct data1: Codable {
    var roomUuid, postTitle, lastMessage, lastMessageDate: String
    var opponentUserImg: String
}

// MARK: - ChatRoomDataModel
struct ChatRoomDataModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data1: Data2
}

struct Data2: Codable {
    var postTitle, postCategory, createdDate, opponentImg, opponentEmail, userEmail: String
    var messageList: [MessageList]
}

struct MessageList: Codable {
    var content, senderEmail, messageType,sendTime: String
}


struct TestModel: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var data1: Data4
}
//test
struct Data4: Codable {
    var postTitle, postCategory, createdDate, opponentEmail, userEmail: String
    var messageList: [MessageList]
}


// MARK: - CreateRoomDataModel
struct CreateRoomDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: Data3
}

// MARK: - Data3
struct Data3: Codable {
    let postTitle, postCategory, createdDate, opponentEmail: String
    let opponentImg: String
    let messageList: [MessageList]
}

// MARK: - SendMessage
struct MessageSendDataModel {
    var chatroomUuid, senderEmail, messageType, content: String
}


// MARK: - ChatRoomExistDataModel
struct ChatRoomExistDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: Data5
}

struct Data5: Codable {
    let roomUUID: String
}

// MARK: - ChatRoomVerificationDataModel
struct ChatRoomVerificationDataModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data1: Data6
}

// MARK: - Data1
struct Data6: Codable {
    let roomUUID: String
    let isBlocked: Bool
}
