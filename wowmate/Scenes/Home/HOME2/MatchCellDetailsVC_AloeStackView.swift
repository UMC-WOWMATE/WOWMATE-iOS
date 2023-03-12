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
    var Img: String = ""
    var MatchCellDetailsTitle = String()
    var MatchCellDetailsCategoty = String()
    var MatchCellDetailsDate = String()
    var MatchCellDetailslikeCount = String()
    var MatchCellDetailsContext = String()
    var MatchCellDetailsMember = String()
    var MatchCellDetailsTagList: [String] = []
    var MatchCellDetailsImageList: [String?] = []
    var MatchCellDetailsComments: [Comment?] = []
    var MatchCellDetailsCommentReplyDtoList: [CommentReply?] = []
    let placeholder = "댓글 작성하기"
    var MatchCellDetailsReplytext = UITextView()
    let accusationOption1:String = "유출/사칭/사기/도배"
    let accusationOption2:String = "욕설/비하"
    let accusationOption3:String = "음란물/불건전한 내용"
    let accusationOption4:String = "상업적 광고 및 판매"
    
    let replytableview = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - Actions
    @objc private func backButtonPressed(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
        }
    
    @objc func moreButtonPressed(_ sender:Any){
        let alert = UIAlertController(title: "게시글관련 옵션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: accusationOption1, style: .default, handler: { action in
                    //업로드 통신
                    let accusationByUser = self.accusationOption1
            
                    PostManager.shared.accusationPost(ID: self.PostID, reason:accusationByUser) { result in
                        print(result)
                        switch result {
                        case .success(let success):
                            print(success)
                            let alert_done = UIAlertController(
                                title: "신고 완료",
                                message: nil,
                                preferredStyle: .alert)
                            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
                            self.present(alert_done, animated: true)
            
                        case .failure(let failure):
                            print(failure)
                        }
                    }
            
                }))
                        
        alert.addAction(UIAlertAction(title: accusationOption2, style: .default, handler: { action in
            let accusationByUser = self.accusationOption2
    
            PostManager.shared.accusationPost(ID: self.PostID, reason:accusationByUser) { result in
                print(result)
                switch result {
                case .success(let success):
                    print(success)
                    let alert_done = UIAlertController(
                        title: "신고 완료",
                        message: nil,
                        preferredStyle: .alert)
                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
    
                    self.present(alert_done, animated: true)
    
                case .failure(let failure):
                    print(failure)
                }
            }
    
        }))
        
        alert.addAction( UIAlertAction(title: accusationOption3, style: .default, handler: { action in
            let accusationByUser = self.accusationOption3
    
            PostManager.shared.accusationPost(ID: self.PostID, reason:accusationByUser) { result in
                print(result)
                switch result {
                case .success(let success):
                    print(success)
                    let alert_done = UIAlertController(
                        title: "신고 완료",
                        message: nil,
                        preferredStyle: .alert)
                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
    
                    self.present(alert_done, animated: true)
    
                case .failure(let failure):
                    print(failure)
                }
            }
    
        }))
        
        alert.addAction(UIAlertAction(title: accusationOption4, style: .default, handler: { action in
            let accusationByUser = self.accusationOption4
    
            PostManager.shared.accusationPost(ID: self.PostID, reason:accusationByUser) { result in
                print(result)
                switch result {
                case .success(let success):
                    print(success)
                    let alert_done = UIAlertController(
                        title: "신고 완료",
                        message: nil,
                        preferredStyle: .alert)
                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
    
                    self.present(alert_done, animated: true)
    
                case .failure(let failure):
                    print(failure)
                }
            }
    
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(alert, animated: true)
        
        
        }
    
//    @objc func commentMoreButtonPressed(_ sender:Any){
//        let alert = UIAlertController(title: "댓글 관련 옵션을 취해주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: accusationOption1, style: .default, handler: { action in
//                    //업로드 통신
//                    let accusationByUser = self.accusationOption1
//
//                    PostManager.shared.accusationPostComment(ID: self.PostID, reason:accusationByUser) { result in
//                        print(result)
//                        switch result {
//                        case .success(let success):
//                            print(success)
//                            let alert_done = UIAlertController(
//                                title: "신고 완료",
//                                message: nil,
//                                preferredStyle: .alert)
//                            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//
//                            self.present(alert_done, animated: true)
//
//                        case .failure(let failure):
//                            print(failure)
//                        }
//                    }
//
//                }))
//
//        alert.addAction(UIAlertAction(title: accusationOption2, style: .default, handler: { action in
//            let accusationByUser = self.accusationOption2
//
//            PostManager.shared.accusationPostComment(ID: self.PostID, reason:accusationByUser) { result in
//                print(result)
//                switch result {
//                case .success(let success):
//                    print(success)
//                    let alert_done = UIAlertController(
//                        title: "신고 완료",
//                        message: nil,
//                        preferredStyle: .alert)
//                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//
//                    self.present(alert_done, animated: true)
//
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
//
//        }))
//
//        alert.addAction( UIAlertAction(title: accusationOption3, style: .default, handler: { action in
//            let accusationByUser = self.accusationOption3
//
//            PostManager.shared.accusationPostComment(ID: self.PostID, reason:accusationByUser) { result in
//                print(result)
//                switch result {
//                case .success(let success):
//                    print(success)
//                    let alert_done = UIAlertController(
//                        title: "신고 완료",
//                        message: nil,
//                        preferredStyle: .alert)
//                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//
//                    self.present(alert_done, animated: true)
//
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
//
//        }))
//
//        alert.addAction(UIAlertAction(title: accusationOption4, style: .default, handler: { action in
//            let accusationByUser = self.accusationOption4
//
//            PostManager.shared.accusationPostComment(ID: self.PostID, reason:accusationByUser) { result in
//                print(result)
//                switch result {
//                case .success(let success):
//                    print(success)
//                    let alert_done = UIAlertController(
//                        title: "신고 완료",
//                        message: nil,
//                        preferredStyle: .alert)
//                    alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//
//                    self.present(alert_done, animated: true)
//
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
//
//        }))
//        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
//
//        self.present(alert, animated: true)
//
//
//        }
    
    @objc func likeButtonPressed(_ sender:Any){
            let alertAction = UIAlertController(title: "게시글을 추천하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
    
            alertAction.addAction(UIAlertAction(title: "취소", style: .default))
            alertAction.addAction(UIAlertAction(title: "추천", style: .default, handler: { action in
                //추천시 동작
                let alert_done = UIAlertController(
                    title: "게시글 추천은 업데이트 예정입니다.",
                    message: nil,
                    preferredStyle: .alert)
                alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))

                self.present(alert_done, animated: true)
            }))
    
            present(alertAction, animated: true)
        }
    
    @objc func replyButtonPressed(_ sender:Any){
        if self.MatchCellDetailsReplytext.text == placeholder {
            let alert_done = UIAlertController(
                title: "댓글 내용을 입력해주세요.",
                message: nil,
                preferredStyle: .alert)
            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            
            self.present(alert_done, animated: true)
            return
        }
        
        let alert = UIAlertController(
                    title: "댓글을 등록하시겠습니까?",
                    message: nil,
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "등록", style: .default, handler: { action in
                    //업로드 통신
                    let commentByUser = CommentRegister(commentContext: self.MatchCellDetailsReplytext.text!)
                    
                    PostManager.shared.registerComment(ID: self.PostID, comment: commentByUser) { result in
                        print(result)
                        switch result {
                        case .success(let success):
                            print(success)
                            let alert_done = UIAlertController(
                                title: "등록 완료",
                                message: nil,
                                preferredStyle: .alert)
                            alert_done.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))

                            self.present(alert_done, animated: true)

//                            self.tableview.reloadData()
//                            self.replytext.text = ""
                            
//                            PostManager.shared.getPost(ID: self.id) { result in
//                                switch result {
//                                         case .success(let success):
//                                    print(success)
//                                    //댓글
//                                    self.comments.removeAll()
//                                            for comment in success.data2 {
//                                                self.comments.append(Comment.init(commentId: comment.commentId,
//                                                                                  commentContext: comment.commentContext,
//                                                                                  likeNumber: comment.likeNumber,
//                                                                                  createdDate: comment.createdDate,
//                                                                                  commentReplyDtoList: comment.commentReplyDtoList))
//                                            }
//                                    self.tableview.reloadData()
//                                         case .failure(let failure):
//                                             print(failure)
//                                         }
//                                     }
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }))
                
                
                
                self.present(alert, animated: true)
            }
    
    @objc func chatButtonPressed(_ sender:Any){
                let alert = UIAlertController(
                    title: "채팅을 시작하시겠습니까??",
                    message: nil,
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "채팅", style: .default, handler: { action in
//                    채팅걸기 통신
                    ChatManager.shared.isExist(String(self.PostID)) { result in
                        print(result)
                        switch result {
                        case .success(let success):
                            print(success)
                            if success.data1.isBlocked {
                                let alert = UIAlertController(
                                    title: "채팅을 걸 수 없습니다.",
                                    message: nil,
                                    preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                                self.present(alert, animated: true)
                                return
                            }
                            
                            let newChatRoom = ChatViewController()
                            newChatRoom.selectRoomUuid = success.data1.roomUuid
//                            newChatRoom.chatRoomData.data1.createdDate =
                            newChatRoom.chatRoomData.data1.postTitle = self.MatchCellDetailsTitle
                            newChatRoom.chatRoomData.data1.opponentImg = self.Img
                            self.navigationController?.pushViewController(newChatRoom, animated: true)

                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }))
                
                self.present(alert, animated: true)
            }
    
    // MARK: - Helpers
    func getData() {
        
        func getDate(_ date:String) -> String {
            return String(date.prefix(10))
        }
        
        PostManager.shared.getPost(ID: PostID) { result in
            switch result {
                     case .success(let success):
                    print(success)
                    self.MatchCellDetailsTitle = success.data1.postTitle
                    self.MatchCellDetailsCategoty = success.data1.categoryName
                    self.MatchCellDetailsDate = getDate(success.data1.createdDate)
                    self.MatchCellDetailslikeCount = String(success.data1.postLikeNumber)
                    self.MatchCellDetailsContext = success.data1.postContext
                    self.MatchCellDetailsMember = success.data1.postMember
                    self.MatchCellDetailsTagList.append(success.data1.postTag1)
                    self.MatchCellDetailsTagList.append(success.data1.postTag2)
                    self.MatchCellDetailsTagList.append(success.data1.postTag3)
                    self.MatchCellDetailsTagList.append(success.data1.postTag4)
                    self.MatchCellDetailsTagList.append(success.data1.postTag5)
                            if success.data1.image1 != nil { self.MatchCellDetailsImageList.append(success.data1.image1!)}
                            if success.data1.image2 != nil { self.MatchCellDetailsImageList.append(success.data1.image2!)}
                            if success.data1.image3 != nil { self.MatchCellDetailsImageList.append(success.data1.image3!)}
                            if success.data1.image4 != nil { self.MatchCellDetailsImageList.append(success.data1.image4!)}
                            if success.data1.image5 != nil { self.MatchCellDetailsImageList.append(success.data1.image5!)}
                    //댓글
                    for comment in success.data2 {
                        self.MatchCellDetailsComments.append(Comment.init(commentId: comment.commentId,
                                                          commentContext: comment.commentContext,
                                                          likeNumber: comment.likeNumber,
                                                          createdDate: comment.createdDate,
                                                          commentReplyDtoList: comment.commentReplyDtoList))
                    }
                
                DispatchQueue.main.async {
                    self.setUpNavigationbarView()
                    self.setUp_Title_moreButton()
                    self.setUp_Date_Like()
                    self.setUp_Category_Member()
                    self.setUp_Tags()
                    self.setUp_Context()
                    self.setUp_Image()
//                    self.setUp_Comments()
                    self.setUp_Comments_tableview()
                    self.setUp_FooterView()
                }
                
                     case .failure(let failure):
                         print(failure)
                     }
                 }
    }
    
    func setUpNavigationbarView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic 1"), style: .plain, target:self , action: #selector(backButtonPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic"), style: .plain, target:self , action: #selector(moreButtonPressed))
    }
    
    func setUp_Title_moreButton() { let TitleLabel = UILabel()
        TitleLabel.font =  .head
        TitleLabel.textColor = .black
        TitleLabel.text = MatchCellDetailsTitle
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addRow(TitleLabel)
        stackView.setInset(forRow: TitleLabel, inset: UIEdgeInsets(top: 6, left: 24, bottom: 6, right: 16))
        stackView.hideSeparator(forRow: TitleLabel)
    }
    
    func setUp_Date_Like() {
        let Date_Like_Row = AloeStackView()
        Date_Like_Row.axis = .horizontal
        Date_Like_Row.rowInset = UIEdgeInsets(top: 6, left: 2, bottom: 6, right: 2)
        Date_Like_Row.hidesSeparatorsByDefault = true
        Date_Like_Row.translatesAutoresizingMaskIntoConstraints = false

        let DateLabel = UILabel()
        DateLabel.font =  .body_16R
        DateLabel.textColor = .black
        DateLabel.text = MatchCellDetailsDate
        DateLabel.textAlignment = .left
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let dotView = UIImageView(image: UIImage(named: "ic 3"))
        dotView.contentMode = .scaleAspectFit
        dotView.translatesAutoresizingMaskIntoConstraints = false

        let LikeButton = UIButton()
        LikeButton.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
        LikeButton.translatesAutoresizingMaskIntoConstraints = false
        LikeButton.addTarget(self, action: #selector(likeButtonPressed), for: .allEvents)

        let LikeLabel = UILabel()
        LikeLabel.text = MatchCellDetailslikeCount
        LikeLabel.font = .body_16R
        LikeLabel.textColor = .black
        LikeLabel.translatesAutoresizingMaskIntoConstraints = false


        Date_Like_Row.addRow(DateLabel)
        Date_Like_Row.addRow(dotView)
        Date_Like_Row.addRow(LikeButton)
        Date_Like_Row.addRow(LikeLabel)
        stackView.addRow(Date_Like_Row)
        stackView.setInset(forRow: Date_Like_Row, inset: UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 8))
        stackView.hideSeparator(forRow: Date_Like_Row)
    }
    
    
    func setUp_Category_Member() {
        let Category_Member_Row = UIStackView()
        Category_Member_Row.axis = .horizontal
        Category_Member_Row.alignment = .center
        Category_Member_Row.distribution = .fillProportionally
        Category_Member_Row.spacing = 24
        Category_Member_Row.translatesAutoresizingMaskIntoConstraints = false

        let CategoryButton = UIButton()
        CategoryButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        CategoryButton.titleLabel?.font = .body_14B
        CategoryButton.layer.cornerRadius = 14
        CategoryButton.setTitle(MatchCellDetailsCategoty, for: .normal)
        CategoryButton.setTitleColor(.white, for: .normal)
        CategoryButton.translatesAutoresizingMaskIntoConstraints = false

        let MemberLabel = UILabel()
        if MatchCellDetailsMember == "무관" {
            MemberLabel.text = "모집인원 무관"
        }
        else {
            MemberLabel.text = "모집인원 " + MatchCellDetailsMember + "명"
        }
        MemberLabel.font = .body_16SB
        MemberLabel.textColor = .black

        Category_Member_Row.addArrangedSubview(CategoryButton)
        Category_Member_Row.addArrangedSubview(MemberLabel)

        stackView.addRow(Category_Member_Row)
        stackView.setInset(forRow: Category_Member_Row, inset: UIEdgeInsets(top: 6, left: 16, bottom: 15.5, right: 8))
    }
    
    func setUp_Tags() {
        if MatchCellDetailsTagList[0] == "" { return }
        
        let TagStackView = AloeStackView()
        TagStackView.axis = .horizontal
        TagStackView.hidesSeparatorsByDefault = true
        TagStackView.rowInset = UIEdgeInsets(top: 0, left: 8, bottom:0, right: 8)
        TagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in MatchCellDetailsTagList {
            if tag != "" {
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
        stackView.setInset(forRow: TagStackView, inset: UIEdgeInsets(top: 16, left: 8, bottom: 15.5, right: 8))
    }
    
    func setUp_Context() {
        let ContextLabel = UILabel()
        ContextLabel.translatesAutoresizingMaskIntoConstraints = false
        ContextLabel.text = "소개"
        ContextLabel.font = .body_16B
        ContextLabel.textColor = .black
        stackView.addRow(ContextLabel)
        stackView.hideSeparator(forRow: ContextLabel)
        stackView.setInset(forRow: ContextLabel, inset: UIEdgeInsets(top: 16, left: 16, bottom: 4, right: 16))
        
        let ContextTextView = UITextView()
        ContextTextView.font = .body_14R
        ContextTextView.text = MatchCellDetailsContext
        ContextTextView.textColor = UIColor(r: 51, g: 51, b: 51)
        ContextTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        ContextTextView.layer.cornerRadius = 10
        ContextTextView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        ContextTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        ContextTextView.translatesAutoresizingMaskIntoConstraints = false
        ContextTextView.isEditable = false
        
        stackView.addRow(ContextTextView)
        stackView.setInset(forRow: ContextTextView, inset: UIEdgeInsets(top: 4, left: 16, bottom: 15.5, right: 16))
    }
    
    func setUp_Image() {
        if self.MatchCellDetailsImageList.isEmpty { return }
        
        let ImageLabel = UILabel()
        ImageLabel.font = .body_16B
        ImageLabel.textColor = UIColor(r: 0, g: 0, b: 0)
        ImageLabel.text = "이미지"
        ImageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(ImageLabel)
        stackView.hideSeparator(forRow: ImageLabel)
        stackView.setInset(forRow: ImageLabel, inset: UIEdgeInsets(top: 16, left: 16, bottom: 4, right: 16))
        
        let ImageStackView = AloeStackView()
        ImageStackView.axis = .horizontal
        ImageStackView.hidesSeparatorsByDefault = true
        ImageStackView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        ImageStackView.layer.cornerRadius = 10
        ImageStackView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        ImageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for image in MatchCellDetailsImageList {
            let url = URL(string: image!)
            let data = UIImageView()
            data.kf.setImage(with: url)
            data.addConstraint(NSLayoutConstraint(item: data, attribute: .width, relatedBy: .equal, toItem: data, attribute: .height, multiplier: 1.0, constant: 0))
            data.contentMode = .scaleAspectFit
            ImageStackView.addRow(data)
        }
        
        stackView.addRow(ImageStackView)
        stackView.setInset(forRow: ImageStackView, inset: UIEdgeInsets(top: 4, left: 16, bottom: 15.5, right: 16))
        
    }
    
    func setUp_Comments() {
        let CommentLabel = UILabel()
        CommentLabel.translatesAutoresizingMaskIntoConstraints = false
        CommentLabel.text = "댓글"
        CommentLabel.font = .body_16B
        CommentLabel.textColor = .black
        stackView.addRow(CommentLabel)
//        stackView.hideSeparator(forRow: CommentLabel)
        
        for comment in MatchCellDetailsComments {
            let firstrow = UIStackView()
            firstrow.axis = .horizontal
            firstrow.distribution = .fill
            
            let commentsWriter = UILabel()
            commentsWriter.font = .body_14R
            commentsWriter.text = "익명" + String(comment!.commentId)
            commentsWriter.textColor = UIColor.WM.gray700
            
            let bt = UIButton()
            bt.setImage(UIImage(imageLiteralResourceName: "ic"), for: .normal)
            
            firstrow.addArrangedSubview(commentsWriter)
            firstrow.addArrangedSubview(bt)
            
            stackView.axis = .vertical
            stackView.addRow(firstrow)
            stackView.hideSeparator(forRow: firstrow)
            stackView.setInset(forRow: firstrow, inset: UIEdgeInsets(top: 12, left: 12, bottom: 4, right: 12))
            
            let secondrow = UIStackView()
            secondrow.axis = .horizontal
            secondrow.distribution = .fill
            
            let lb = UILabel()
            lb.text = comment?.commentContext
            lb.font = .body_14R
            lb.textColor = UIColor.WM.gray700
            lb.numberOfLines = 0
//
            secondrow.addArrangedSubview(lb)
//            secondrow.axis = .horizontal
//            secondrow.distribution = .fill
            
            stackView.addRow(secondrow)
            stackView.hideSeparator(forRow: secondrow)
            stackView.setInset(forRow: secondrow, inset: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
            
            let thirdrow = UIStackView()
            secondrow.axis = .horizontal
            secondrow.distribution = .fill
            
            let container = UIStackView()
            secondrow.axis = .horizontal
            secondrow.alignment = .leading
            
//            let commentreply = UIButton()
//            bt.setImage(UIImage(imageLiteralResourceName: "개별"), for: .normal)
//
//            let commentlike = UIButton()
//            bt.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
//
//            let commentreplycount = UILabel()
//            commentreplycount.text = String(comment!.commentReplyDtoList.count)
//            commentreplycount.font = .body_14R
//            commentreplycount.textColor = UIColor.WM.gray700
//
//            let commentlikecount = UILabel()
//            commentlikecount.text = String(comment!.likeNumber)
//            commentlikecount.font = .body_14R
//            commentlikecount.textColor = UIColor.WM.gray700
//
//            container.addArrangedSubview(commentreply)
//            container.addArrangedSubview(commentlike)
//            container.addArrangedSubview(commentreplycount)
//            container.addArrangedSubview(commentlikecount)
            
            let datetext = UILabel()
            datetext.text = comment?.createdDate
            datetext.font = .body_11L
            datetext.textColor = UIColor.WM.gray500
            datetext.numberOfLines = 1
            
            thirdrow.addArrangedSubview(container)
            thirdrow.addArrangedSubview(datetext)
            
            stackView.addRow(thirdrow)
            stackView.setInset(forRow: firstrow, inset: UIEdgeInsets(top: 9, left: 12, bottom: 8, right: 12))
        }
        
    }
    
    func setUp_Comments_tableview() {
        let stackview = UIStackView()
        stackview.backgroundColor = .white
        //        let tableviewHeight = 80 * MatchCellDetailsComments.count
        replytableview.translatesAutoresizingMaskIntoConstraints = false
        replytableview.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        stackview.addArrangedSubview(replytableview)
        self.replytableview.delegate = self
        self.replytableview.dataSource = self
        self.replytableview.register(DetailReplyCell.self, forCellReuseIdentifier: "DetailReplyCell")
        self.replytableview.separatorStyle = .none
        //        self.replytableview.layoutIfNeeded()
        self.replytableview.rowHeight = 70
        stackView.addRow(stackview)
        
    }
    
    func setUp_FooterView() {
        let FooterStackView = UIStackView()
        let ReplyStackView = UIStackView()
        FooterStackView.axis = .vertical
        FooterStackView.spacing = 10
        ReplyStackView.axis = .horizontal
        ReplyStackView.spacing = 8
        
        MatchCellDetailsReplytext.delegate = self
        MatchCellDetailsReplytext.text = placeholder
        MatchCellDetailsReplytext.font = .body_14R
        MatchCellDetailsReplytext.textContainerInset = UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 10)
        MatchCellDetailsReplytext.layer.cornerRadius = 5
        MatchCellDetailsReplytext.backgroundColor = UIColor(r: 242, g: 242, b: 242)
        MatchCellDetailsReplytext.heightAnchor.constraint(equalToConstant: 32).isActive = true
        MatchCellDetailsReplytext.translatesAutoresizingMaskIntoConstraints = false
        
        let ReplyButton = UIButton()
        ReplyButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        ReplyButton.setTitle("등록", for: .normal)
        ReplyButton.titleLabel?.font = .body_14B
        ReplyButton.tintColor = .white
        ReplyButton.layer.cornerRadius = 5
        ReplyButton.addTarget(self, action: #selector(replyButtonPressed), for: .allEvents)
        ReplyButton.translatesAutoresizingMaskIntoConstraints = false
        
        ReplyStackView.addArrangedSubview(MatchCellDetailsReplytext)
        ReplyStackView.addArrangedSubview(ReplyButton)
        
        let ChatButton = UIButton()
        ChatButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
        ChatButton.setTitle("채팅 걸기", for: .normal)
        ChatButton.titleLabel?.font = .subHead_18B
        ChatButton.tintColor = .white
        ChatButton.layer.cornerRadius = 5
        ChatButton.addTarget(self, action: #selector(chatButtonPressed), for: .allEvents)
        ChatButton.translatesAutoresizingMaskIntoConstraints = false
        
        FooterStackView.addArrangedSubview(ReplyStackView)
        FooterStackView.addArrangedSubview(ChatButton)
        
        stackView.addRow(FooterStackView)
    }
}

extension MatchCellDetailsVC_AloeStackView: UITextViewDelegate {
    //TextView - Reply
    func textViewDidBeginEditing(_ textView: UITextView) {
            /// 플레이스홀더
            if textView.text.isEmpty {
                MatchCellDetailsReplytext.textColor = UIColor(r: 51, g: 51, b: 51)
                MatchCellDetailsReplytext.text = placeholder
            } else if textView.text == placeholder {
                MatchCellDetailsReplytext.textColor = .black
                MatchCellDetailsReplytext.text = nil
            }
        }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        /// 플레이스홀더
        if textView.text.isEmpty {
            MatchCellDetailsReplytext.textColor = UIColor(r: 51, g: 51, b: 51)
            MatchCellDetailsReplytext.text = placeholder
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard velocity.y != 0 else { return }
                if velocity.y < 0 {
                    let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
                    self?.tabBarController?.tabBar.alpha = 1.0
                    self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
                } else {
                self?.tabBarController?.tabBar.alpha = 0.0
                    self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
                }
            }
        }
}

extension MatchCellDetailsVC_AloeStackView:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return self.MatchCellDetailsComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailReplyCell") as! DetailReplyCell
        cell.backgroundColor = .white
        cell.usertext.text = MatchCellDetailsComments[indexPath.row]?.commentContext
        cell.datetext.text = MatchCellDetailsComments[indexPath.row]?.createdDate
//        cell.detailreplyreactionVC.heartButtonCount.text = String(MatchCellDetailsComments[indexPath.row]?.likeNumber)
//        cell.detailreplyreactionVC.likeButtonCount.text = String(MatchCellDetailsComments[indexPath.row].)
//        cell.userid.text = "익명" + " \(MatchCellDetailsComments[indexPath.row].commentId)"
        return cell
    }
}
