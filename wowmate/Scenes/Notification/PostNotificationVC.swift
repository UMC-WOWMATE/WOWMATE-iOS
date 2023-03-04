//
//  PostNotificationVC.swift
//  wowmate
//
//  Created by 이지웅 on 2023/03/03.
//


import UIKit

class PostNotificationVC: UITableViewController {
    // MARK: - Properties
    // 변수 및 상수, IBOutlet
    
    // MARK: - Lifecycle
    // 생명주기와 관련된 메서드 (viewDidLoad, viewDidDisappear...)
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        tableView.register(PostNotificationCell.self, forCellReuseIdentifier: "PostNotificationCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostNotificationCell", for: indexPath) as! PostNotificationCell
        // Configure the cell...
        cell.PostNotificationTitle.text = "PostNoti title"
        cell.PostNotificationContext.text = "PostNoti context"
        cell.PostNotificationDate.text = "PostNoti date"
        cell.separatorInset.left = .zero
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Replace with the number of cells you want to display
    }
}
