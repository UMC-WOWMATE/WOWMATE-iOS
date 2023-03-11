//
//  ChatViewController.swift
//  wowmate
//  채팅 화면
//
//  Created by 장윤정 on 2023/01/24.
//

import UIKit
import SwiftUI
import Moya
import StompClientLib

private let cellID = "BubbleCell"

class ChatViewController: UIViewController {
      
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    ---------[for sizing)]---------
    var maxWidth = UIScreen.main.bounds.size.width
    
//    ---------[Real Use Data]---------
    lazy var chatRoomData:ChatRoomDataModel = ChatRoomDataModel(isSuccess: true, code: 200, message: "SUCCESS", data1: data)
    lazy var data:Data2 = Data2(postTitle: "고양이 좋아", postCategory: "동물", createdDate: "채팅 생성일 2023.01.01", opponentImg: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU", opponentEmail: "opponent@gmail.com", userEmail: "my@gmail.com", messageList: messageList)
    var messageList:[MessageList] = [
        MessageList(content: "안녕하세요~ㅎㅎㅎ", senderEmail: "opponent@gmail.com", messageType: "ENTER", sendTime: "2023년 01월 01일 14:30:15"),
        MessageList(content: "반가워요~~ㅎㅎㅎ", senderEmail: "my@gmail.com", messageType: "TEXT", sendTime: "2023년 01월 02일 14:35:15"),
        MessageList(content: "안녕하세요~ㅎㅎㅎ", senderEmail: "opponent@gmail.com", messageType: "TEXT", sendTime: "2023년 01월 02일 14:30:15"),
        MessageList(content: "반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ반가워요~~ㅎㅎㅎ", senderEmail: "my@gmail.com", messageType: "TEXT", sendTime: "2023년 01월 02일 14:35:15")
        
    ]
    
//    ---------[Test Data]---------
    lazy var testData:TestModel = TestModel(isSuccess: true, code: 200, message: "SUCCESS", data1: test)
    lazy var test:Data4 = Data4(postTitle: "고양이 좋아", postCategory: "동물", createdDate: "채팅 생성일 2023.01.01", opponentEmail: "opponent@gmail.com", userEmail: "my@gmail.com", messageList: messageList)
    
    
    var selectRoomUuid:String = ""
    
//    ---------[for method(isSameDate)]---------
    var preDate:String = ""
    
//    ---------[UI components]---------
    let chatTableView = UITableView()
    
    // navigation bar의 right item
    let menuImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        // 이미지 색 바꾸기
        //imageView.tintColor = UIColor.init(red: 101, green: 81, blue: 224, alpha: 1)
        imageView.tintColor = .black
        
        imageView.contentMode = .scaleToFill
        imageView.setDimensions(height: 19.5, width: 19.5)
        
        return imageView
    }()
    
    // 메시지 입력 및 보내는 영역 item
    lazy var messageField:UITextField = {
        let textfield = UITextField()
        
        textfield.placeholder = "메시지 보내기"
        textfield.placeholderColor(UIColor.WM.gray700)
        
        textfield.textColor = UIColor.WM.black
        textfield.font = .body_14R
        
        textfield.setDimensions(height: 32, width: (view.frame.width - 68))
        textfield.layer.cornerRadius = 10
        textfield.backgroundColor = UIColor.WM.gray100
        
        textfield.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        textfield.leftViewMode = .always
        
        return textfield
    }()
    
    let sendButton:UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.setDimensions(height: 24, width: 24)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.WM.main500

        return button
    }()
    
    lazy var messageStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.messageField, self.sendButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        return stackView
    }()
    
    let matchButton:UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "main_icon"), for: .normal)
        button.setDimensions(height: 57, width: 57)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = 57 / 2
        button.clipsToBounds = true
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // 데이터 받아오기 + 소캣 오픈
        fetchChatRoomData(state: "first")
        
        // UI 설정
        configureUI()
        
        
        // 동작 설정
        setMessageSendAction()
        setMatchMessageSendButton()
        
//        print(selectRoomUuid)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 채팅방 VC가 사라지면 채팅 소캣 닫음
//        SocketIOManager.shared.closeConnection()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    // method to setting a message send button
    func setMessageSendAction() {
        var sendObject: MessageSendDataModel = MessageSendDataModel(chatroomUuid: selectRoomUuid, senderEmail: data.userEmail, messageType: "TEXT", content: "WOWMATE")
        let sendAction = UIAction { _ in
            let sendmess = String(self.messageField.text ?? "")
            if sendmess != "" {
                sendObject.content = sendmess
            }
            
//            // 임시 메세지 보내기 기능
//            let messList:MessageList = MessageList(content: self.messageField.text!, senderEmail: self.chatRoomData.data1.userEmail, messageType: "TEXT", sendTime: self.getSendTime())
//            self.chatRoomData.data1.messageList.append(messList)
//            self.chatTableView.reloadData()
            
            StompManager.shared.sendMessage(sendObject)
            
            // 메세지 입력창 비우기
            self.messageField.text = ""
            
            self.fetchChatRoomData(state: "recall")
        }
        
        sendButton.addAction(sendAction, for: .touchUpInside)
        
    }
    
    // method to setting a matching message send button
    func setMatchMessageSendButton() {
        let matchSendAction = UIAction { _ in
            let sendmess = String("상대방이 매칭 요청을 보냈습니다. 수락하시려면 하단 매칭 버튼을 눌러주세요.")
            print(sendmess)
        }
        
        matchButton.addAction(matchSendAction, for: .touchUpInside)

    }
    
    
    
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    // UI 관련 함수
    
    // method - setting whole of View
    func configureUI() {
        
        view.backgroundColor = .white
        changeStatusBarBgColor(bgColor: UIColor.white)
        
        chatTableView.register(BubbleCell.self, forCellReuseIdentifier: cellID)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        // dynamic row height of cell
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        view.addSubview(messageStackView)
        view.addSubview(chatTableView)
        view.addSubview(matchButton)
        
        messageStackView.setDimensions(height: 32, width: view.frame.width)
        messageStackView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 36, paddingRight: 16)
        
        chatTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: messageStackView.topAnchor, right: view.rightAnchor, paddingBottom: 10)
        
        matchButton.anchor(bottom: messageStackView.topAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
    }
    
    // method - setting tableView header
    func setHeader() {
        
        let headerView:UIView = {
            let view = ChatHeader(frame: CGRect(x: 0, y: 0 , width: view.frame.width, height: 80))
            
            let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU") //chatRoomData.data1.opponentImg)
            view.profileImage.load(url: url!)
            
            view.titleLabel.text = self.chatRoomData.data1.postTitle
            view.cateLabel.text = self.chatRoomData.data1.postCategory
            view.chatMadeDateLabel.text = self.chatRoomData.data1.createdDate
            
            return view
            
        }()
        
        chatTableView.tableHeaderView = headerView
        chatTableView.tableHeaderView?.layer.borderWidth = 0.5
        chatTableView.tableHeaderView?.layer.borderColor = UIColor.WM.gray400.cgColor
        
    }
    
    // method - setting navigation controller
    func setNC() {
        
        self.navigationItem.title = chatRoomData.data1.postTitle
        
        // toggle
        // right bar item
        let rightCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 19.5, height: 19.5))
        
        rightCustomView.addSubview(menuImage)
        menuImage.translatesAutoresizingMaskIntoConstraints = false
        
        let rightBarItem = UIBarButtonItem(customView: rightCustomView)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    

    // method - get date
    func getDate(_ date:String) -> String {
        return String(date.prefix(13))
    }
    
    // method - check date
    func isSameDate(_ date:String) -> Bool {
        let nowdate = getDate(date)
        if preDate == nowdate {
            return true
        } else if preDate != nowdate {
            preDate = nowdate
        }
        return false
    }
    
    // method - get time
    func getTime(_ time:String) -> String {
        let timeStartIndex = time.index(time.startIndex, offsetBy: 14)
        let timeEndIndex = time.index(time.startIndex, offsetBy: 18)
        let returnTime = String(time[timeStartIndex...timeEndIndex])
        
        return returnTime
    }
    
    // method - get sendTime
    func getSendTime() -> String {
        let today = Date() // 현재의 Date 날짜 및 시간
        let dayFormatter = DateFormatter() // Day 포맷 객체 선언
        
        dayFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm:ss" // Day 포맷 타입 지정
        let now_string = dayFormatter.string(from: today) // 포맷된 형식 문자열로 반환
        
        return now_string
    }
    
    
//    ---------[methods to get WeekDay]---------
    
    func checkLeap(year: Int) -> Bool {
        var checkValue: Bool = false
        if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0){
            checkValue = true
        }else {
            checkValue = false
        }
        return checkValue
    }
    
    func endDayOfMonth(year: Int, month: Int) -> Int {
        
        var endDay: Int = 0
        let inputMonth: Int = month
        
        let monA: Set = [1,3,5,7,8,10,12]
        let monB: Set = [4,6,9,11]
        
        if monA.contains(inputMonth)  {
            endDay = 31
        }else if monB.contains(inputMonth) {
            endDay = 30
        }
        
        if inputMonth == 2 {
            if checkLeap(year: year) {
                endDay = 29
            }else {
                endDay = 28
            }
        }
        return endDay
    }
    
    func getWeekDay(_ date:String) -> String {
        guard let atYear = Int(date.prefix(4)) else { return "2023" }
        
        let monthStartIndex = date.index(date.startIndex, offsetBy: 6)
        let monthEndIndex = date.index(date.startIndex, offsetBy: 7)
        guard let atMonth = Int(date[monthStartIndex...monthEndIndex]) else { return "01" }
        
        let dayStartIndex = date.index(date.startIndex, offsetBy: 10)
        let dayEndIndex = date.index(date.startIndex, offsetBy: 11)
        guard let atDay = Int(date[dayStartIndex...dayEndIndex]) else { return "01" }
        
        let dayDay:[String] = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"]
        var returnValue: String = ""
        var totalDay: Int = 0
        
        for i in 1..<atMonth {
            totalDay += endDayOfMonth(year: atYear, month: i)
        }
        
        var index: Int = 0
        if (totalDay + atDay) % 7 == 0 {
            index = 6
        }else {
            index = (totalDay + atDay) % 7 - 1
        }
        
        returnValue = dayDay[index]
        
        return returnValue
    }
    
//    ---------[methods to get data from server]---------
    func fetchChatRoomData(state:String) {
        ChatManager.shared.getChatRoom(selectRoomUuid) { result in
            
            switch result {
            case .success(let data):
                self.chatRoomData = data
                
                self.setHeader()
                self.setNC()
                self.chatTableView.reloadData()
                
                self.chatTableView.scrollToRow(at: IndexPath(row: self.chatRoomData.data1.messageList.count  - 1, section: 0),at: .bottom, animated: false)
//                SocketIOManager.shared.establishConnection()
                
                if state == "first" {
                    // TODO: - 서버 연결
                    StompManager.shared.registerSockect()
                    StompManager.shared.subscribe(roomId: self.selectRoomUuid)
                }
            
                print(data)
            case .failure(let Error):
                print(Error)
            }
            
        }
    }
    
    
}

// MARK: - Tableview Extensions

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomData.data1.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BubbleCell
        
        cell.selectionStyle = .none
        
        if isSameDate(chatRoomData.data1.messageList[indexPath.row].sendTime) {
            if chatRoomData.data1.userEmail == chatRoomData.data1.messageList[indexPath.row].senderEmail {
                cell.myConfigureUI()
                cell.myMessage.text = chatRoomData.data1.messageList[indexPath.row].content
                cell.myTimeLabel.text = getTime(chatRoomData.data1.messageList[indexPath.row].sendTime)
                
            } else {
                cell.otherConfigureUI()
                cell.opponentMessage.text = chatRoomData.data1.messageList[indexPath.row].content
                cell.opponentTimeLabel.text = getTime(chatRoomData.data1.messageList[indexPath.row].sendTime)
            }
        } else {
            let dateString = getDate(chatRoomData.data1.messageList[indexPath.row].sendTime)
            cell.dateLabel.text = dateString + " " + getWeekDay(dateString)
            
            if chatRoomData.data1.userEmail == chatRoomData.data1.messageList[indexPath.row].senderEmail {
                cell.dateMyConfigureUI()
                cell.myMessage.text = chatRoomData.data1.messageList[indexPath.row].content
                cell.myTimeLabel.text = getTime(chatRoomData.data1.messageList[indexPath.row].sendTime)
            } else {
                cell.dateOtherConfigureUI()
                cell.opponentMessage.text = chatRoomData.data1.messageList[indexPath.row].content
                cell.opponentTimeLabel.text = getTime(chatRoomData.data1.messageList[indexPath.row].sendTime)
            }
        }
       
        return cell
    }
    
    
}

extension ChatViewController:UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - No Use Functions

//    // footview로 메시지 보내는 영역 설정하기
//    func setTB() {
//        self.navigationController?.isToolbarHidden = false
//
//        let footView = UIBarButtonItem(customView: ChatFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 32)))
//
//        self.toolbarItems = [footView]
//
//
//    }


