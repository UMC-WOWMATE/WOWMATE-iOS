//
//  MatchCellDetailsVC_AloeStackView.swift
//  wowmate
//
//  Created by 이지웅 on 2023/03/05.
//

import Foundation
import UIKit
import AloeStackView
import Moya
import Kingfisher

class MatchCellDetailsVC_AloeStackView: AloeStackViewController {
    // MARK: - Properties
    var PostID: Int = -1
    
    let MatchCellDetailsTitle = String()
    let MatchCellDetailsCategoty = String()
    let MatchCellDetailsDate = String()
    let MatchCellDetailslikeCount = String()
    let MatchCellDetailsContext = String()
    let MatchCellDetailsMember = String()
    var tagList: [String] = []
    var imageList: [String?] = []
    var comments: [Comment?] = []
    var commentReplyDtoList: [CommentReply?] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationbarView()
        
    }
    
    // MARK: - Actions
    @objc private func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
        }
    
    @objc func AddButton(_ sender:Any){
            let alertAction = UIAlertController(title: "게시글관련 옵션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
    
            alertAction.addAction(UIAlertAction(title: "삭제", style: .default))
            alertAction.addAction(UIAlertAction(title: "차단", style: .default))
            alertAction.addAction(UIAlertAction(title: "신고", style: .default))
    
            present(alertAction, animated: true)
        }
    
    
    
    // MARK: - Helpers
    func setUpNavigationbarView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic 1"), style: .plain, target:self , action: #selector(backButtonPressed))
    }
    
    func setUp_Title_addButton() {
        let TitleRow = UIStackView()
        TitleRow.axis = .horizontal
        TitleRow.translatesAutoresizingMaskIntoConstraints = false
        
        //    let MatchCellDetailsAddButton = UIButton()
    }
    
    func setUp_Date_Like() {
        //    let MatchCellDetailslikeButton = UIButton()
    }
    
    func setUp_Category() {
        
    }
    
    func setUp_Member() {
        
    }
    
    func setUp_Tags() {
        
    }
    
    func setUp_Context() {
        
    }
    
    func setUp_Image() {
        
    }
    
    func setUp_Comments() {
        
    }
}
