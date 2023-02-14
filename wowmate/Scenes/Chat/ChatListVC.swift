//
//  ChatListVC.swift
//  wowmate
//  채팅 목록 화면
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit

private let cellID = "ChatListCell"

// MARK: - Data

let SookImageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU"
let SeoulImageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMkklrIPJWIVzKvdw0-pGJE1tiokGazEbf_A&usqp=CAU"

//struct chatListData {
//    var profileImageUrl: String
//    var matchTitle: String
//    var recentChat: String
//    var recentChatTime: String
//    var recentChatRead: String
//    var category:String
//    var chatMade:String
//}
//
//var chatList:[chatListData] = [
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아하는 사람!!", recentChat: "안녕하세요! 반가워요ㅎㅎ", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "같이 운동할 사람 구해요", recentChat: "어떤 운동하세요?", recentChatTime: "오전 03:15", recentChatRead: "읽음", category: "운동", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "한강 가실 분?", recentChat: "안녕하세요~", recentChatTime: "오전 00:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "강아지 좋아하는 사람!", recentChat: "강아지 이름이 뭐예요?", recentChatTime: "오후 11:28", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "밴드 공연 좋아하니?", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "생필품 나눌 사람?", recentChat: "에에에 너 왕 싫음", recentChatTime: "오후 02:35", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "옷 골라줘", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "친구 필요한 사람", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "놀이공원?", recentChat: "반가워요~", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "운동 좋아", recentChat: "반가워요~", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
//
//]


class ChatListVC: UIViewController {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    ---------[Real Use Data]---------
    lazy var chatRoomListData:ChatRoomListDataModel = ChatRoomListDataModel(isSuccess: true, code: 200, message: "SUCCESS", data1: data)
    var data:[data1] = [
        data1(roomUuid: "df02975e-b63d-490e-b11b-4196f3ad2266", postTitle: "게시글 1번", lastMessage: "가워요~ㅎㅎㅎ", lastMessageDate: "2023년 01월 02일 14:35:15", opponentUserImg: SookImageUrl)
    ]
    
    
    var read:String = "안읽음"
    
    let chatTableView = UITableView()
    

    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 받아오기
        fetchChatRoomListData()
        
        // UI 설정
        configureUI()
        
        setNCBI()
        setChatNCBar()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

    func configureUI() {
        
        view.backgroundColor = .white
        changeStatusBarBgColor(bgColor: UIColor.WM.white)
        
        chatTableView.register(ChatListCell.self, forCellReuseIdentifier: cellID)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        
        view.addSubview(chatTableView)
        
        chatTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 60)
    }
    
    func setNCBI() {
        self.navigationController?.navigationBar.backgroundColor = .white
 
        
        // left bar item
        let leftCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 25))
        
        let titleLabel: UILabel = {
            let label = UILabel()
            
            label.text = "채팅"
            label.textColor = .black
            label.font = .boldSystemFont(ofSize: 25)
            
            return label
        }()
        
        leftCustomView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBarItem = UIBarButtonItem(customView: leftCustomView)
        self.navigationItem.leftBarButtonItem = leftBarItem
        
        // right bar item
        let rightCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 19.5, height: 19.5))
        
        let bellImage: UIImageView = {
            let imageView = UIImageView()
            
            imageView.image = UIImage(systemName: "bell")
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            
            // 이미지 색 바꾸기
            //imageView.tintColor = UIColor.init(red: 101, green: 81, blue: 224, alpha: 1)
            imageView.tintColor = .black
            
            imageView.contentMode = .scaleToFill
            imageView.setDimensions(height: 19.5, width: 19.5)
            
            return imageView
        }()
        
        rightCustomView.addSubview(bellImage)
        bellImage.translatesAutoresizingMaskIntoConstraints = false
        
        let rightBarItem = UIBarButtonItem(customView: rightCustomView)
        self.navigationItem.rightBarButtonItem = rightBarItem
        
    }
    
    func hideNavigationBar() {
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func setChatNCBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor.WM.black
        
        // back button custom
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    
    }
    
    func getNow() -> String {
        let today = Date() // 현재의 Date 날짜 및 시간
        let dayFormatter = DateFormatter() // Day 포맷 객체 선언
        
        dayFormatter.dateFormat = "yyyy년 MM월 dd일" // Day 포맷 타입 지정
        let day_string = dayFormatter.string(from: today) // 포맷된 형식 문자열로 반환
        
        return day_string
    }
    
    // method - get date
    func getDate(_ date:String) -> String {
        return String(date.prefix(13))
    }
    
    func getDay(_ date:String) -> String {
        let dayStartIndex = date.index(date.startIndex, offsetBy: 7)
        let dayEndIndex = date.index(date.startIndex, offsetBy: 13)
        let returnDay = String(date[dayStartIndex...dayEndIndex])
        
        return returnDay
    }
    
    // method - get time
    func getTime(_ time:String) -> String {
        let timeStartIndex = time.index(time.startIndex, offsetBy: 14)
        let timeEndIndex = time.index(time.startIndex, offsetBy: 18)
        let returnTime = String(time[timeStartIndex...timeEndIndex])
        
        return returnTime
    }
    
    
    
//    ---------[Network]---------

    func fetchChatRoomListData() {
        ChatManager.shared.getChatRoomList { result in
            switch result {
            case .success(let data):
                self.chatRoomListData.data1 = data.data1
                self.chatTableView.reloadData()
                print(data)
            case .failure(let Error):
                print(Error)
            }
        }
        self.chatRoomListData.data1 = self.data
        self.chatTableView.reloadData()
        
    }
    
    
}

// MARK: - Extensions
extension ChatListVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomListData.data1.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatListCell
        
        // cell contents setting
        
        // 프로필 이미지
//        let url = URL(string: chatRoomListData.data[indexPath.row].opponentUserImg)
        let url = URL(string: SookImageUrl)
        cell.profileImage.load(url: url!)
        
        // 매칭 제목
        cell.titleLabel.text = chatRoomListData.data1[indexPath.row].postTitle
        
        // 최근 대화 내용
        cell.recentChatLabel.text = chatRoomListData.data1[indexPath.row].lastMessage
        
        // 최근 대화 시각
        if getNow() == getDate(chatRoomListData.data1[indexPath.row].lastMessageDate){
            print("---------같은 날----------")
            cell.timeLabel.text = getTime(chatRoomListData.data1[indexPath.row].lastMessageDate)
        } else {
            print("---------다른 날----------")
            cell.timeLabel.text = getDay(chatRoomListData.data1[indexPath.row].lastMessageDate)
        }
        
        // 새로운 메세지 표시 chatListData.data1[indexPath.row].recentChatRead
        if (read == "읽음") {
            cell.newMessageImage.alpha = 0
        } else if (read == "안읽음") {
            cell.newMessageImage.alpha = 1
        }
        
        return cell
    }
}

extension ChatListVC: UITableViewDelegate {
    // MARK: - Setting Size of Cells
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let chatController = ChatViewController()
        
        navigationController?.pushViewController(chatController, animated: true)
      
        // New 표시 제어 - 새로운 메세지 읽으면 New 표시 없앰
        if (read == "안읽음") {
            read = "읽음"
            tableView.reloadData()
        }
        
        // 선택한 채팅방 값 넘기기
        chatController.selectRoomUuid = chatRoomListData.data1[indexPath.row].roomUuid
        
    }
}



