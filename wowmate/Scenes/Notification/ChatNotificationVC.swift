//
//  ChatNotificationVC.swift
//  wowmate
//
//  Created by 이지웅 on 2023/03/04.
//

import UIKit

class ChatNotificationVC: UITableViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        tableView.register(ChatNotificationCell.self, forCellReuseIdentifier: "ChatNotificationCell")
        tableView.rowHeight = 98
    }

    // MARK: - Actions
    // IBAction 및 사용자 인터랙션과 관련된 메서드 정의
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let matchdetails = MatchCellDetailsVC()
////            matchdetails.id = posts[indexPath.row].postId
//        self.navigationController?.pushViewController(matchdetails, animated: true)
//    }
    
    // MARK: - HELPERS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatNotificationCell", for: indexPath) as! ChatNotificationCell
        // Configure the cell...
        cell.ChatNotificationTitle.text = "ChatNoti title"
        cell.ChatNotificationContext.text = "ChatNoti context"
        cell.ChatNotificationDate.text = "ChatNoti date"
        cell.separatorInset.left = .zero
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Replace with the number of cells you want to display
    }
}
