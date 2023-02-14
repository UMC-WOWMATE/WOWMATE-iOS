//
//  SocketIOManager.swift
//  wowmate
//
//  Created by 장윤정 on 2023/02/07.
//

import Foundation
import SocketIO

class SocketIOManager {
    
    static let shared = SocketIOManager()
    
    // 서버랑 메시지를 주고 받기 위한 클래스
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    private init() {
            manager = SocketManager(socketURL: URL(string: " localhost:8080/ws-chat")!, config: [
                .log(true), .compress])
            
            socket = manager.defaultSocket
            
            // 연결
            socket.on(clientEvent: .connect) { data, ack in
                print("SOCKET IS CONNECTED", data, ack)
            }
            
            // 연결 해제
            socket.on(clientEvent: .disconnect) { data, ack in
                print("SOCKET IS DISCONNECTED", data, ack)
            }
            
            // 이벤트 수신
            socket.on("Special") { dataArray, ack in
                print("Special RECEIVED", dataArray, ack)
            }
    }
    
    // 연결하고 끊는 메서드
    func establishConnection() {
        socket.connect()
        print("TRYING TO CONNECT SOCKET")
        
    }
    
    func closeConnection() {
        socket.disconnect()
        print("TRYING TO DISCONNECT SOCKET")
    
    }
    
}
