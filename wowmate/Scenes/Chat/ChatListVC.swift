//
//  ChatListVC.swift
//  wowmate
//
//  Created by Doy Kim on 2023/01/08.
//

import UIKit

private let cellID = "ChatListCell"

// MARK: - Data

let SookImageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzg8B0MB919OvJrv57cUBNlZ7mXUFTxQg0Ww&usqp=CAU"
let SeoulImageUrl: String = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMkklrIPJWIVzKvdw0-pGJE1tiokGazEbf_A&usqp=CAU"

struct chatListData{
    var profileImageUrl: String
    var matchTitle: String
    var recentChat: String
    var recentChatTime: String
    var recentChatRead: String
    var category:String
    var chatMade:String
}

var chatList:[chatListData] = [
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아하는 사람!!", recentChat: "안녕하세요! 반가워요ㅎㅎ", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "같이 운동할 사람 구해요", recentChat: "어떤 운동하세요?", recentChatTime: "오전 03:15", recentChatRead: "읽음", category: "운동", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "한강 가실 분?", recentChat: "안녕하세요~", recentChatTime: "오전 00:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "강아지 좋아하는 사람!", recentChat: "강아지 이름이 뭐예요?", recentChatTime: "오후 11:28", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "밴드 공연 좋아하니?", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "생필품 나눌 사람?", recentChat: "에에에 너 왕 싫음", recentChatTime: "오후 02:35", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "옷 골라줘", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "친구 필요한 사람", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "놀이공원?", recentChat: "반가워요~", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "운동 좋아", recentChat: "반가워요~", recentChatTime: "오후 04:15", recentChatRead: "안읽음", category: "스포츠", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SeoulImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    chatListData(profileImageUrl: SookImageUrl, matchTitle: "고양이 좋아", recentChat: "안녕하세요~", recentChatTime: "오후 04:15", recentChatRead: "읽음", category: "동물", chatMade: "2023 01 28"),
    
]


class ChatListVC: UIViewController {

    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
//    var maxWidth = UIScreen.main.bounds.width
    
    let chatTableView = UITableView()
    

    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setNCBI()
        setChatNCBar()
    }
    
    // MARK: - 상단바2
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        //hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
//        setChatNCBar()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의

    func configureUI() {
        
        view.backgroundColor = .white
        changeStatusBarBgColor(bgColor: UIColor.white)
        
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
        navigationController?.navigationBar.tintColor = .black
        
        // back button custom
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        

    }
    
    
}

// MARK: - Extensions
extension ChatListVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatListCell
        
        // cell contents setting
        
        // 프로필 이미지
        let url = URL(string: chatList[indexPath.row].profileImageUrl)
        cell.profileImage.load(url: url!)
        
        // 매칭 제목
        cell.titleLabel.text = chatList[indexPath.row].matchTitle
        
        // 최근 대화 내용
        cell.recentChatLabel.text = chatList[indexPath.row].recentChat
        
        // 최근 대화 시각
        cell.timeLabel.text = chatList[indexPath.row].recentChatTime
        
        // 새로운 메세지 표시
        if (chatList[indexPath.row].recentChatRead == "읽음") {
            cell.newMessageImage.tintColor = UIColor.clear
        } else if (chatList[indexPath.row].recentChatRead == "안읽음") {
            cell.newMessageImage.tintColor = UIColor.WM.main500
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
        
        // 데이터 넘겨 주기
        let chatController = ChatViewController()
        chatController.navTitle = chatList[indexPath.row].matchTitle
        chatController.profImage = chatList[indexPath.row].profileImageUrl
        chatController.headerTitle = chatList[indexPath.row].matchTitle
        chatController.headerCate = chatList[indexPath.row].category
        chatController.headerChatMade = chatList[indexPath.row].chatMade
        
        navigationController?.pushViewController(chatController, animated: true)
      
        // New 표시 제어 - 새로운 메세지 읽으면 New 표시 없앰
        if (chatList[indexPath.row].recentChatRead == "안읽음") {
            chatList[indexPath.row].recentChatRead = "읽음"
            tableView.reloadData()
        }
        
    }
}



