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
import SnapKit

class MatchCellDetailsVC_AloeStackView: AloeStackViewController {
    // MARK: - Properties
    var PostID: Int = -1
    var MatchCellDetailsTitle = String()
    var MatchCellDetailsCategoty = String()
    var MatchCellDetailsDate = String()
    var MatchCellDetailslikeCount = String()
    var MatchCellDetailsContext = String()
    var MatchCellDetailsMember = String()
    var tagList: [String] = []
    var imageList: [String?] = []
    var comments: [Comment?] = []
    var commentReplyDtoList: [CommentReply?] = []
    
    
    let tableview = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        setUpNavigationbarView()
        setUp_Title_moreButton()
        setUp_Date_Like()
        setUp_Category()
        setUp_Member()
        setUp_Tags()
        setUp_Context()
        setUp_Image()
        setUp_Comments()
        tableviewSet()
       
        
    }
    
    // MARK: - Actions
    @objc private func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
        }
    
    @objc func moreButtonPressed(_ sender:Any){
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
    
    func setUp_Title_moreButton() {
        let Title_Row = UIStackView()
        Title_Row.axis = .horizontal
        Title_Row.translatesAutoresizingMaskIntoConstraints = false
        
        let TitleLabel = UILabel()
        TitleLabel.font =  .head
        TitleLabel.textColor = .black
        TitleLabel.text = MatchCellDetailsTitle
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let MoreButton = UIButton()
        MoreButton.translatesAutoresizingMaskIntoConstraints = false
        MoreButton.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
        MoreButton.addTarget(self, action: #selector(moreButtonPressed), for: .allEvents)
        
        Title_Row.addArrangedSubview(TitleLabel)
        Title_Row.addArrangedSubview(MoreButton)
        stackView.addRow(Title_Row)
        stackView.hideSeparator(forRow: Title_Row)
    }
    
    func setUp_Date_Like() {
        let Date_Like_Row = UIStackView()
        Date_Like_Row.axis = .horizontal
        Date_Like_Row.translatesAutoresizingMaskIntoConstraints = false
        
        let DateLabel = UILabel()
        DateLabel.font =  .body_14R
        DateLabel.textColor = .black
        DateLabel.text = "등록일 : " + MatchCellDetailsDate
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let LikeStackView = UIStackView()
        LikeStackView.axis = .horizontal
        LikeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let LikeButton = UIButton()
        LikeButton.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
//        LikeButton.addTarget(self, action: #selector(moreButtonPressed), for: .allEvents)

        let LikeLabel = UILabel()
        LikeLabel.font =  .body_14R
        LikeLabel.textColor = .black
        LikeLabel.text = MatchCellDetailslikeCount
        LikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        LikeStackView.addArrangedSubview(LikeButton)
        LikeStackView.addArrangedSubview(LikeLabel)
        
        Date_Like_Row.addArrangedSubview(DateLabel)
        Date_Like_Row.addArrangedSubview(LikeStackView)
        stackView.addRow(Date_Like_Row)
        stackView.hideSeparator(forRow: Date_Like_Row)
    }
    
    func setUp_Category() {
        var CategoryButton = UIButton()
        CategoryButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        CategoryButton.titleLabel?.font = .body_14B
        CategoryButton.layer.cornerRadius = 16
        CategoryButton.setTitle(MatchCellDetailsCategoty, for: .normal)
        CategoryButton.setTitleColor(.white, for: .normal)
        CategoryButton.widthAnchor.constraint(equalToConstant: 96).isActive = true
        CategoryButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
//        CategoryButton.tintColor = UIColor(r: 101, g: 81, b: 224)
//        CategoryButton.layer.shadowColor = UIColor.black.cgColor
//        CategoryButton.layer.shadowOpacity = 0.1
//        CategoryButton.layer.shadowOffset = CGSize(width: 10, height: 10)
        CategoryButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(CategoryButton)
        stackView.hideSeparator(forRow: CategoryButton)
    }
    
    func setUp_Member() {
        let MemberLabel = UILabel()
        if MatchCellDetailsMember == "무관" {
            MemberLabel.text = "모집인원 무관"
        }
        else {
            MemberLabel.text = "모집인원 " + MatchCellDetailsMember + "명"
        }
        MemberLabel.font = .body_16SB
        MemberLabel.textColor = .black
        
        stackView.addRow(MemberLabel)
    }
    
    func setUp_Tags() {
        var TagStackView = AloeStackView()
        TagStackView.axis = .horizontal
        TagStackView.hidesSeparatorsByDefault = true
        TagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in tagList {
            if tag != "" {
//                let TagLabel = UILabel()
//                TagLabel.text = "#" + tag
//                TagLabel.font = .body_14B
//                TagLabel.textAlignment = .center
//                TagLabel.textColor = .white
//                TagLabel.backgroundColor = UIColor(r: 101, g: 81, b: 224)
//                TagLabel.layer.cornerRadius = 10
//                TagLabel.translatesAutoresizingMaskIntoConstraints = false
                let TagLabel = UIButton()
                TagLabel.setTitle("  #" + tag + "  ", for: .normal)
                TagLabel.titleLabel?.font = .body_14B
                TagLabel.setTitleColor(.white, for: .normal)
                TagLabel.backgroundColor = UIColor(r: 101, g: 81, b: 224)
                TagLabel.layer.cornerRadius = 10
                TagLabel.translatesAutoresizingMaskIntoConstraints = false
                
                TagStackView.addRow(TagLabel)
            }
        }
        
        stackView.addRow(TagStackView)
    }
    
    func setUp_Context() {
        let ContextLabel = UILabel()
        ContextLabel.text = "소개"
        ContextLabel.font = .body_16B
        ContextLabel.textColor = .black
        
        let ContextTextView = UITextView()
        ContextTextView.textColor = UIColor.WM.gray700
        ContextTextView.font = .body_14R
        ContextTextView.backgroundColor = UIColor.WM.gray100
        
        stackView.addRow(ContextLabel)
        stackView.addRow(ContextTextView)
    }
    
    func setUp_Image() {
        
    }
    
    func setUp_Comments() {
        let sample:String = "sample"
        
        let firstrow = UIStackView()
        firstrow.axis = .horizontal
        firstrow.distribution = .fill
               
        let commentsWriter = UILabel()
        commentsWriter.font = .body_14R
        commentsWriter.text = "익명 1"
        commentsWriter.textColor = UIColor.WM.gray700
               
        let bt = UIButton()
        bt.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
    
        firstrow.addArrangedSubview(commentsWriter)
        firstrow.addArrangedSubview(bt)
        
        stackView.axis = .vertical
        stackView.hidesSeparatorsByDefault = true
        stackView.addRow(firstrow)
            
        let secondrow = UIStackView()
        secondrow.axis = .horizontal
        secondrow.distribution = .fill
               
        let lb = UILabel()
        lb.text = "댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다."
        lb.font = .body_14R
        lb.textColor = UIColor.WM.gray700
        lb.numberOfLines = 0
               
        secondrow.addArrangedSubview(lb)
        stackView.addRow(secondrow)
               
        let commentreply = UIButton()
        commentreply.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        
        commentreply.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }

        let commentlike = UIButton()
        commentlike.setImage(UIImage(imageLiteralResourceName: "chat"), for: .normal)

        
        commentlike.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }
               
        let commentlikecount = UILabel()
        commentlikecount.text = sample
        commentlikecount.font = .body_14R
        commentlikecount.textColor = UIColor.WM.gray700
        
        let comentreplaycount = UILabel()
        comentreplaycount.text = sample
        comentreplaycount.font = .body_14R
        comentreplaycount.textColor = UIColor.WM.gray700
        
               
        let datetext = UILabel()
        datetext.text = "2023-12-20"
        datetext.font = .body_11L
        datetext.textColor = UIColor.WM.gray500
        datetext.numberOfLines = 1
        
        let thridRowCompoent = UIStackView()
        thridRowCompoent.axis = .horizontal
        thridRowCompoent.translatesAutoresizingMaskIntoConstraints = false
        thridRowCompoent.distribution = .fill
        
        let thirdrow = UIStackView()
        thirdrow.translatesAutoresizingMaskIntoConstraints = false
        thirdrow.distribution = .fill
        thirdrow.axis = .horizontal
        thirdrow.alignment = .center
        
        thridRowCompoent.addArrangedSubview(commentreply)
        thridRowCompoent.addArrangedSubview(commentlike)
        thridRowCompoent.addArrangedSubview(commentlikecount)
        thirdrow.addArrangedSubview(thridRowCompoent)
        thirdrow.addArrangedSubview(datetext)
        
        stackView.addRow(thirdrow)

    }
    
    func setUp_Commentsreply(){
        let sample:String = "sample"
        
        let firstrow = UIStackView()
        firstrow.axis = .horizontal
        firstrow.distribution = .fill
               
        let commentsWriter = UILabel()
        commentsWriter.font = .body_14R
        commentsWriter.text = "익명 1"
        commentsWriter.textColor = UIColor.WM.gray700
               
        let bt = UIButton()
        bt.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
    
        firstrow.addArrangedSubview(commentsWriter)
        firstrow.addArrangedSubview(bt)
        
        stackView.axis = .vertical
        stackView.hidesSeparatorsByDefault = true
        stackView.addRow(firstrow)
            
        let secondrow = UIStackView()
        secondrow.axis = .horizontal
        secondrow.distribution = .fill
               
        let lb = UILabel()
        lb.text = "댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다.댓글내용 놀사람 구합니다."
        lb.font = .body_14R
        lb.textColor = UIColor.WM.gray700
        lb.numberOfLines = 0
               
        secondrow.addArrangedSubview(lb)
        stackView.addRow(secondrow)
               
        let commentreply = UIButton()
        commentreply.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        
        commentreply.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }

        let commentlike = UIButton()
        commentlike.setImage(UIImage(imageLiteralResourceName: "chat"), for: .normal)

        
        commentlike.snp.makeConstraints { make in
        make.size.width.equalTo(14)
        make.size.height.equalTo(14)
        }
               
        let commentlikecount = UILabel()
        commentlikecount.text = sample
        commentlikecount.font = .body_14R
        commentlikecount.textColor = UIColor.WM.gray700
        
        let comentreplaycount = UILabel()
        comentreplaycount.text = sample
        comentreplaycount.font = .body_14R
        comentreplaycount.textColor = UIColor.WM.gray700
        
               
        let datetext = UILabel()
        datetext.text = "2023-12-20"
        datetext.font = .body_11L
        datetext.textColor = UIColor.WM.gray500
        datetext.numberOfLines = 1
        
        let thridRowCompoent = UIStackView()
        thridRowCompoent.axis = .horizontal
        thridRowCompoent.translatesAutoresizingMaskIntoConstraints = false
        thridRowCompoent.distribution = .fill
        
        let thirdrow = UIStackView()
        thirdrow.translatesAutoresizingMaskIntoConstraints = false
        thirdrow.distribution = .fill
        thirdrow.axis = .horizontal
        thirdrow.alignment = .center
        
        thridRowCompoent.addArrangedSubview(commentreply)
        thridRowCompoent.addArrangedSubview(comentreplaycount)
        thridRowCompoent.addArrangedSubview(commentlike)
        thridRowCompoent.addArrangedSubview(commentlikecount)
        thirdrow.addArrangedSubview(thridRowCompoent)
        thirdrow.addArrangedSubview(datetext)
        
        stackView.addRow(thirdrow)
        
        let replystackview = UIStackView()
        replystackview.axis = .horizontal
        replystackview.distribution = .fill
        replystackview.alignment = .center
        replystackview.spacing = 10
        
        let replybt = UIButton()
        replybt.setImage(UIImage(imageLiteralResourceName: "Vector"), for: .normal)
        
        replystackview.addArrangedSubview(replybt)
        replystackview.addArrangedSubview(stackView)
    
    }
    
    
    
    
    
    
    //    func row7(){
    //
    //        let tv = UITextView()
    //        tv.textColor = UIColor.WM.gray700
    //        tv.font = .body_14R
    //        tv.backgroundColor = UIColor.WM.gray100
    //
    //        view.addSubview(tv)
    //
    //        tv.snp.makeConstraints { make in
    //            make.leading.right.equalTo(stackView).offset(16)
    //            make.trailing.equalTo(stackView).offset(-16)
    //            make.height.equalTo(110)
    //            make.top.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
    //
    //                }
    //
    //    }
    
    func test() {
        self.MatchCellDetailsTitle = "제목"
        self.MatchCellDetailsCategoty = "카테고리"
        self.MatchCellDetailsDate = "2000.03.31"
        self.MatchCellDetailslikeCount = " 2500"
        self.MatchCellDetailsContext = "내용"
        self.MatchCellDetailsMember = "30000"
        self.tagList.append("tag1")
        self.tagList.append("tag2")
        self.tagList.append("tag3")
        self.tagList.append("tag4")
        self.tagList.append("tag5")
        
//        var imageList: [String?] = []
//        var comments: [Comment?] = []
//        var commentReplyDtoList: [CommentReply?] = []
        
    }
    
    func tableviewSet(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(replyCell.self, forCellReuseIdentifier: "replyCell")
        self.tableview.reloadData()
//        self.tableview.separatorStyle
        self.tableview.layoutIfNeeded()
        self.tableview.rowHeight = 70
        stackView.addRow(tableview)
        
    }
    
   
}

extension MatchCellDetailsVC_AloeStackView:UITableViewDataSource,UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell") as! replyCell
        
        return cell
    }
   
}


