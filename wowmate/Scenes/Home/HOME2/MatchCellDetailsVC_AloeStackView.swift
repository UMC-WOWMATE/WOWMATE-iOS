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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
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
                    self.tagList.append(success.data1.postTag1)
                    self.tagList.append(success.data1.postTag2)
                    self.tagList.append(success.data1.postTag3)
                    self.tagList.append(success.data1.postTag4)
                    self.tagList.append(success.data1.postTag5)
                            if success.data1.image1 != nil { self.imageList.append(success.data1.image1!)}
                            if success.data1.image2 != nil { self.imageList.append(success.data1.image2!)}
                            if success.data1.image3 != nil { self.imageList.append(success.data1.image3!)}
                            if success.data1.image4 != nil { self.imageList.append(success.data1.image4!)}
                            if success.data1.image5 != nil { self.imageList.append(success.data1.image5!)}
                    //댓글
                    for comment in success.data2 {
                        self.comments.append(Comment.init(commentId: comment.commentId,
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
                    self.setUp_Comments()
                }
                
                     case .failure(let failure):
                         print(failure)
                     }
                 }
    }
    
    func setUpNavigationbarView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(imageLiteralResourceName:"ic 1"), style: .plain, target:self , action: #selector(backButtonPressed))
    }
    
    func setUp_Title_moreButton() {print(MatchCellDetailsTitle)
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
    
    func setUp_Date_Like() {print(MatchCellDetailsDate)
        print(MatchCellDetailslikeCount)
        let Date_Like_Row = UIStackView()
        Date_Like_Row.axis = .horizontal
        Date_Like_Row.alignment = .leading
        Date_Like_Row.distribution = .fillProportionally
//        Date_Like_Row.spacing = 2
        Date_Like_Row.translatesAutoresizingMaskIntoConstraints = false

        let DateLabel = UILabel()
        DateLabel.font =  .body_16R
        DateLabel.textColor = .black
        DateLabel.text = MatchCellDetailsDate
        DateLabel.textAlignment = .left
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        DateLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true

        let LikeButton = UIButton()
        LikeButton.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
//        LikeButton.widthAnchor.constraint(equalToConstant: 10.5).isActive = true
        LikeButton.setTitle(MatchCellDetailslikeCount, for: .normal)
        LikeButton.titleLabel?.font = .body_16R
        LikeButton.setTitleColor(.black, for: .normal)

//        let LikeLabel = UILabel()
//        LikeLabel.text = MatchCellDetailslikeCount
//        LikeLabel.font = .body_16R


        Date_Like_Row.addArrangedSubview(DateLabel)
        Date_Like_Row.addArrangedSubview(LikeButton)
//        Date_Like_Row.addArrangedSubview(LikeLabel)
        stackView.addRow(Date_Like_Row)
        stackView.hideSeparator(forRow: Date_Like_Row)
    }
    
//    func setUp_Date_Like() {
//        let Date_Like_Row = UIView()
//
//        let DateLabel = UILabel()
//        DateLabel.font =  .body_16R
//        DateLabel.textColor = .black
//        DateLabel.text = MatchCellDetailsDate
//        DateLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true
//        DateLabel.leadingAnchor.constraint(equalTo: Date_Like_Row.leadingAnchor, constant: 22).isActive = true
//        DateLabel.topAnchor.constraint(equalTo: Date_Like_Row.topAnchor, constant: 20).isActive = true
//        DateLabel.backgroundColor = .green
//
//        Date_Like_Row.addSubview(DateLabel)
////        let LikeButton = UIButton()
////        Date_Like_Row.addSubview(LikeButton)
////        LikeButton.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
////        LikeButton.leadingAnchor.constraint(equalTo: DateLabel.trailingAnchor, constant: 30).isActive = true
////        LikeButton.setTitle(MatchCellDetailslikeCount, for: .normal)
////        LikeButton.titleLabel?.font = .body_16R
////        LikeButton.setTitleColor(.black, for: .normal)
////        LikeButton.backgroundColor = .green
////        let LikeLabel = UILabel()
////        LikeLabel.text = MatchCellDetailslikeCount
////        LikeLabel.font = .body_16R
////
////        LikeStackView.addArrangedSubview(LikeButton)
////        LikeStackView.addArrangedSubview(LikeLabel)
//
//
////        Date_Like_Row.addArrangedSubview(dot)
////        Date_Like_Row.addArrangedSubview(LikeStackView)
//
////        Date_Like_Row.addArrangedSubview(LikeLabel)
//
//        Date_Like_Row.heightAnchor.constraint(equalToConstant: 100).isActive = true
////        Date_Like_Row.backgroundColor = .orange
//        stackView.addRow(Date_Like_Row)
//        stackView.hideSeparator(forRow: Date_Like_Row)
//    }
    
    func setUp_Category_Member() {print(MatchCellDetailsCategoty)
        print(MatchCellDetailsMember)
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
//        CategoryButton.configuration
//        CategoryButton.widthAnchor.constraint(equalToConstant: 96).isActive = true
//        CategoryButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
//        CategoryButton.translatesAutoresizingMaskIntoConstraints = false

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
        stackView.hideSeparator(forRow: Category_Member_Row)
    }
    
//    func setUp_Category_Member() {
//        let Category_Member_Row = UIView()
//        Category_Member_Row.translatesAutoresizingMaskIntoConstraints = false
//
//        let CategoryButton = UIButton()
//        CategoryButton.backgroundColor = UIColor(r: 101, g: 81, b: 224)
//        CategoryButton.titleLabel?.font = .body_14B
//        CategoryButton.layer.cornerRadius = 14
//        CategoryButton.setTitle(MatchCellDetailsCategoty, for: .normal)
//        CategoryButton.setTitleColor(.white, for: .normal)
//        CategoryButton.translatesAutoresizingMaskIntoConstraints = false
//
//        let MemberLabel = UILabel()
//        if MatchCellDetailsMember == "무관" {
//            MemberLabel.text = "모집인원 무관"
//        }
//        else {
//            MemberLabel.text = "모집인원 " + MatchCellDetailsMember + "명"
//        }
//        MemberLabel.font = .body_16SB
//        MemberLabel.textColor = .black
//        MemberLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        Category_Member_Row.addSubview(CategoryButton)
//        Category_Member_Row.addSubview(MemberLabel)
//
//        NSLayoutConstraint.activate([
//            MemberLabel.leadingAnchor.constraint(equalTo: Category_Member_Row.trailingAnchor, constant: 50)])
//
//        stackView.addRow(Category_Member_Row)
//        stackView.hideSeparator(forRow: Category_Member_Row)
//    }
    
    
    func setUp_Tags() {
        let TagStackView = AloeStackView()
        TagStackView.axis = .horizontal
        TagStackView.hidesSeparatorsByDefault = true
        TagStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in tagList {
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
    }
    
    func setUp_Context() {
        let ContextLabel = UILabel()
        ContextLabel.translatesAutoresizingMaskIntoConstraints = false
        ContextLabel.text = "소개"
        ContextLabel.font = .body_16B
        ContextLabel.textColor = .black
        stackView.addRow(ContextLabel)
        stackView.hideSeparator(forRow: ContextLabel)
        
        let ContextTextView = UITextView()
//        ContextTextView.delegate = self
        ContextTextView.font = .body_14R
        ContextTextView.text = MatchCellDetailsContext
        ContextTextView.textColor = UIColor(r: 51, g: 51, b: 51)
        ContextTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        ContextTextView.layer.cornerRadius = 10
        
        ContextTextView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
//        ContextTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        ContextTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
        ContextTextView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addRow(ContextTextView)
    }
    
    func setUp_Image() {
        let ImageLabel = UILabel()
        ImageLabel.font = .body_16B
        ImageLabel.textColor = UIColor(r: 0, g: 0, b: 0)
        ImageLabel.text = "이미지"
        ImageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addRow(ImageLabel)
        stackView.hideSeparator(forRow: ImageLabel)
        
        let ImageStackView = AloeStackView()
        ImageStackView.axis = .horizontal
        ImageStackView.hidesSeparatorsByDefault = true
        ImageStackView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        ImageStackView.layer.cornerRadius = 10
        ImageStackView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        ImageStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for image in imageList {
            let url = URL(string: image!)
            let data = UIImageView()
            data.kf.setImage(with: url)
            data.addConstraint(NSLayoutConstraint(item: data, attribute: .width, relatedBy: .equal, toItem: data, attribute: .height, multiplier: 1.0, constant: 0))
            data.contentMode = .scaleAspectFit
            ImageStackView.addRow(data)
        }
        
        stackView.addRow(ImageStackView)
        
    }
    
    func setUp_Comments() {
        let CommentLabel = UILabel()
        CommentLabel.translatesAutoresizingMaskIntoConstraints = false
        CommentLabel.text = "댓글"
        CommentLabel.font = .body_16B
        CommentLabel.textColor = .black
        stackView.addRow(CommentLabel)
        stackView.hideSeparator(forRow: CommentLabel)
        
        let sample:String = "sample"
        
        let firstrow = UIStackView()
               firstrow.axis = .horizontal
               firstrow.distribution = .fill
               
               let commentsWriter = UILabel()
               commentsWriter.font = .body_14R
               commentsWriter.text = sample
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
               lb.text = sample
               lb.font = .body_14R
               lb.textColor = UIColor.WM.gray700
               lb.numberOfLines = 0
               
               secondrow.addArrangedSubview(lb)
               secondrow.axis = .horizontal
               secondrow.distribution = .fill
               
               stackView.addRow(secondrow)
               
               let thirdrow = UIStackView()
               secondrow.axis = .horizontal
               secondrow.distribution = .fill
               
               let container = UIStackView()
               secondrow.axis = .horizontal
               secondrow.alignment = .leading
               
               let commentreply = UIButton()
               bt.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)

               let commentlike = UIButton()
               bt.setImage(UIImage(imageLiteralResourceName: "ic 2"), for: .normal)
               
               let commentreplycount = UILabel()
               commentreplycount.text = sample
               commentreplycount.font = .body_14R
               commentreplycount.textColor = UIColor.WM.gray700
               
               let commentlikecount = UILabel()
               commentlikecount.text = sample
               commentlikecount.font = .body_14R
               commentlikecount.textColor = UIColor.WM.gray700
               
               container.addArrangedSubview(commentreply)
               container.addArrangedSubview(commentlike)
               container.addArrangedSubview(commentreplycount)
               container.addArrangedSubview(commentlikecount)
               
               let datetext = UILabel()
               datetext.text = sample
               datetext.font = .body_11L
               datetext.textColor = UIColor.WM.gray500
               datetext.numberOfLines = 1
               
               thirdrow.addArrangedSubview(container)
               thirdrow.addArrangedSubview(datetext)
               
               stackView.addRow(thirdrow)
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
        self.MatchCellDetailslikeCount = "2500"
        self.MatchCellDetailsContext = "내용"
        self.MatchCellDetailsMember = "30000"
        self.tagList.append("tag1")
        self.tagList.append("tag2")
        self.tagList.append("tag3")
        self.tagList.append("tag4")
        self.tagList.append("tag5")
        self.imageList.append("https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/c92e32ab-a03f-4b04-a0a1-11baf3498462.jpg")
        self.imageList.append("https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/48d2a989-4f0e-4b28-8e03-f9240e0df076.jpg")
        self.imageList.append("https://wowmate-server-s3.s3.ap-northeast-2.amazonaws.com/8d616432-a2ea-45f5-97c7-8688f9035392.jpg")
        
//        var comments: [Comment?] = []
//        var commentReplyDtoList: [CommentReply?] = []
        
    }
}
