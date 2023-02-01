//
//  ChatViewController.swift
//  wowmate
//
//  Created by 장윤정 on 2023/01/24.
//

import UIKit
import SwiftUI

private let cellID = "BubbleCell"

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    var maxWidth = UIScreen.main.bounds.size.width
    
    var navTitle:String = "매칭 제목"
    var profImage:String = ""
    lazy var headerTitle:String = self.navTitle
    var headerCate:String = "카테고리"
    var headerChatMade:String = "채팅 생성일 20NN.NN.NN"
    
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setNC()
        setTB()
        addShowMenuGesture()
    }
    
    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
    
    
    // MARK: - Helpers
    // 설정, 데이터처리 등 액션 외의 메서드를 정의
    // UI 관련 함수
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        chatTableView.register(BubbleCell.self, forCellReuseIdentifier: cellID)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        
        setHeader()
        
        view.addSubview(chatTableView)

        chatTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func setHeader() {
        
        let headerView:UIView = {
            let view = ChatHeader(frame: CGRect(x: 0, y: 0 , width: view.frame.width, height: 80))
            
            let url = URL(string: profImage)
            view.profileImage.load(url: url!)
            
            view.titleLabel.text = headerTitle
            view.cateLabel.text = headerCate
            view.chatMadeDateLabel.text = headerChatMade
            
            return view
            
        }()
        
        chatTableView.tableHeaderView = headerView
        chatTableView.tableHeaderView?.layer.borderWidth = 0.5
        chatTableView.tableHeaderView?.layer.borderColor = UIColor.WM.gray_400.cgColor
        
    }
    
    func setNC() {
        
        self.navigationItem.title = navTitle
        
        // toggle
        // right bar item
        let rightCustomView = UIView(frame: CGRect(x: 0, y: 0, width: 19.5, height: 19.5))
        
        rightCustomView.addSubview(menuImage)
        menuImage.translatesAutoresizingMaskIntoConstraints = false
        
        let rightBarItem = UIBarButtonItem(customView: rightCustomView)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func setTB() {
        self.navigationController?.isToolbarHidden = false
        
        let footView = UIBarButtonItem(customView: ChatFooter(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 32)))
        
        self.toolbarItems = [footView]
    }
    
    func addShowMenuGesture() {
        let showMenuGesture = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        self.menuImage.addGestureRecognizer(showMenuGesture)
        
    }
    
    @objc func showMenu() {
        print("신고")
    }

}

// MARK: - Extensions

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BubbleCell
        cell.maxWidth = self.maxWidth
        return cell
    }
    
    
}
extension ChatViewController:UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
