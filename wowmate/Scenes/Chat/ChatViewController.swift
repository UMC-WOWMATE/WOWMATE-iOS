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

private let cellID = "BubbleCell"

class ChatViewController: UIViewController {
    
    // MARK: - Network Extension
    
    private let chatRoomProvider = MoyaProvider<ChatAPI>()
    
     
        
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    ---------[for sizing)]---------
    var maxWidth = UIScreen.main.bounds.size.width
    
//    var navTitle:String = "매칭 제목"
//    var profImage:String = ""
//    lazy var headerTitle:String = self.navTitle
//    var headerCate:String = "카테고리"
//    var headerChatMade:String = "채팅 생성일 20NN.NN.NN"
    
//    ---------[Sample Data]---------
    lazy var sampleChatRoomData:ChatRoomDataModel = ChatRoomDataModel(isSuccess: true, code: 200, message: "SUCCESS", data1: sampleData)
    lazy var sampleData:Data2 = Data2(postTitle: "고양이 좋아", postCategory: "동물", createdDate: "채팅 생성일 2023.01.01", opponentImg: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU", opponentEmail: "opponent@gmail.com", userEmail: "my@gmail.com", messageList: sampleMessagrList)
    var sampleMessagrList:[MessageList] = [
        MessageList(content: "안녕하세요~ddkkdkdkldshdhfkldhfkahkfdhhdslhsdhldsf", senderEmail: "opponent@gmail.com", sendDate: "2023년 01월 01일 14:30:15"),
        MessageList(content: "반가워요~~", senderEmail: "my@gmail.com", sendDate: "2023년 01월 02일 14:35:15")
    ]
    
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
        
//        stackView.setDimensions(height: 32, width: (view.frame.width - 32))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UI 설정
        configureUI()
        setNC()
        
        // 동작 설정
        setSendAction()
        
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    func setSendAction() {
        
        let sendAction = UIAction { _ in
            let sendmess = String(self.messageField.text ?? "")
            if sendmess != "" {
                print(sendmess)
            }
        }
        
        sendButton.addAction(sendAction, for: .touchUpInside)
        
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
        
        
        setHeader()
        
        view.addSubview(messageStackView)
        view.addSubview(chatTableView)
        
        messageStackView.setDimensions(height: 32, width: view.frame.width)
        messageStackView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 36, paddingRight: 16)
        
        chatTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: messageStackView.topAnchor, right: view.rightAnchor, paddingBottom: 10)
    
    }
    
    // method - setting tableView header
    func setHeader() {
        
        let headerView:UIView = {
            let view = ChatHeader(frame: CGRect(x: 0, y: 0 , width: view.frame.width, height: 80))
            
            let url = URL(string: sampleChatRoomData.data1.opponentImg)
            view.profileImage.load(url: url!)
            
            view.titleLabel.text = sampleChatRoomData.data1.postTitle
            view.cateLabel.text = sampleChatRoomData.data1.postCategory
            view.chatMadeDateLabel.text = sampleChatRoomData.data1.createdDate
            
            return view
            
        }()
        
        chatTableView.tableHeaderView = headerView
        chatTableView.tableHeaderView?.layer.borderWidth = 0.5
        chatTableView.tableHeaderView?.layer.borderColor = UIColor.WM.gray400.cgColor
        
    }
    
    // method - setting navigation controller
    func setNC() {
        
        self.navigationItem.title = sampleChatRoomData.data1.postTitle
        
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
    
    
//    ---------[methods for get WeekDay]---------
    
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
        
//        print("---------------\(returnValue)-----------------")
        return returnValue
    }
}

// MARK: - Tableview Extensions

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleChatRoomData.data1.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BubbleCell
        
        let dateString = getDate(sampleChatRoomData.data1.messageList[indexPath.row].sendDate)
        cell.dateLabel.text = dateString + " " + getWeekDay(dateString)
        
        if isSameDate(sampleChatRoomData.data1.messageList[indexPath.row].sendDate) {
            if sampleChatRoomData.data1.userEmail == sampleChatRoomData.data1.messageList[indexPath.row].senderEmail {
                cell.myConfigureUI()
                cell.myMessage.text = sampleChatRoomData.data1.messageList[indexPath.row].content
                cell.myTimeLabel.text = getTime(sampleChatRoomData.data1.messageList[indexPath.row].sendDate)
                
            } else {
                cell.otherConfigureUI()
                cell.opponentMessage.text = sampleChatRoomData.data1.messageList[indexPath.row].content
                cell.opponentTimeLabel.text = getTime(sampleChatRoomData.data1.messageList[indexPath.row].sendDate)
            }
        } else {
            if sampleChatRoomData.data1.userEmail == sampleChatRoomData.data1.messageList[indexPath.row].senderEmail {
                cell.dateMyConfigureUI()
                cell.myMessage.text = sampleChatRoomData.data1.messageList[indexPath.row].content
                cell.myTimeLabel.text = getTime(sampleChatRoomData.data1.messageList[indexPath.row].sendDate)
            } else {
                cell.dateOtherConfigureUI()
                cell.opponentMessage.text = sampleChatRoomData.data1.messageList[indexPath.row].content
                cell.opponentTimeLabel.text = getTime(sampleChatRoomData.data1.messageList[indexPath.row].sendDate)
            }
        }
       
// MARK: - 테스트하고 지우기
//        if indexPath.row == 0 {
//            cell.backgroundColor = .red
//        } else if indexPath.row == 1 {
//            cell.backgroundColor = .orange
//        } else {
//            cell.backgroundColor = .blue
//        }
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

//// MARK: - Network Extension
//extension ChatViewController {
//
//    func fetchChatRoom() {
//        chatRoomProvider.request(.chatRoom("1")) { result in
//            switch result {
//            case .success(let data):
//                guard let givenChatRoomData = try? JSONDecoder().decode(ChatRoomModel.self, from: data.data)
//                else { return }
//
//                print("SUCCESS", givenChatRoomData)
//                break
//            case .failure(_):
//                <#code#>
//            }
//        }
//    }
//
//}


