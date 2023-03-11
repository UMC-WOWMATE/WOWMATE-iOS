//
//  StompManager.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/26.
//

import Foundation
import StompClientLib

class StompManager {

    static let shared: StompManager = StompManager()
    
    // Socket Client instance
    var socketClient = StompClientLib()

    // Socket Connection URL
    private let url = URL(string: "wss://hs-archive.shop/ws-chat/websocket")!

    let header = [
            "Authorization": UserDefaults.standard.value(forKey: "token") as! String // 키체인에서 불러온 Auth 토큰
        ]
    
    // Socket Connection
    func registerSockect() {
        socketClient.openSocketWithURLRequest(
            request: NSURLRequest(url: url as URL),
            delegate: self as StompClientLibDelegate, connectionHeaders: header
        )
    }

    func subscribe(roomId: String) {
        let destination = "/pub/chat/room/\(roomId)"
        if socketClient.isConnected() {
            socketClient.subscribe(destination: destination)
        }
    }

    // Send Message
    func sendMessage(_ sendMessage:MessageSendDataModel) {
        var messageObject : [String : Any] = ["chatroomUuid" : sendMessage.chatroomUuid, "senderEmail" : sendMessage.senderEmail, "messageType" : sendMessage.messageType, "content" : sendMessage.content]

        socketClient.sendJSONForDict(
            dict: messageObject as AnyObject,
            toDestination: "/pub/chat/message"
        )

    }

    // Unsubscribe
    func disconnect() {
        socketClient.disconnect()
    }

}

extension StompManager: StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
    }
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTINATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is connected successfully!")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error : \(String(describing: message))")
        // 연결에 실패하였습니다.
    }
    func serverDidSendPing() {
        print("Server Ping")
    }
}
